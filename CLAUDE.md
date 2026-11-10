# homebrew-tap

Homebrew tap for jmcgarr's CLI tools. Formulas download prebuilt release
binaries; nothing is compiled here.

- One file per tool in `Formula/`. Follow the shape of `Formula/git-grab.rb`:
  no `version` line (Homebrew reads it from the `url`, and `brew audit`
  rejects a redundant one), `on_macos`/`on_linux` with `on_arm`/`on_intel`
  blocks, the release tag literally in every `url`, a `livecheck` block
  before the platform blocks, an offline `test do`.
- Homebrew 7 requires `brew trust jmcgarr/tap` before loading formulas from
  this tap. CI does it; the README tells users to.
- `bin/update-formula <formula> <tag>` is the only way versions and
  checksums change. Never hand-edit a sha256.
- `update-formula.yml` commits to `main` directly after installing and
  testing on a macOS runner. `tests.yml` runs on every push and PR on macOS
  and Linux.
- Check before pushing: `brew style Formula/<f>.rb` and
  `brew audit --strict --online --formula Formula/<f>.rb`.
- Commit messages for bumps are `<formula> <version>`, which is what the
  workflow writes.
