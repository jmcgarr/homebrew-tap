# homebrew-tap

Homebrew tap for jmcgarr's CLI tools. Formulas download prebuilt release
binaries; nothing is compiled here.

- One file per tool in `Formula/`. Follow the shape of `Formula/git-grab.rb`:
  explicit `version`, `on_macos`/`on_linux` with `on_arm`/`on_intel` blocks,
  `#{version}` in every `url`, a `livecheck` block, an offline `test do`.
- `bin/update-formula <formula> <tag>` is the only way versions and
  checksums change. Never hand-edit a sha256.
- `update-formula.yml` commits to `main` directly after installing and
  testing on a macOS runner. `tests.yml` runs on every push and PR on macOS
  and Linux.
- Check before pushing: `brew style Formula/<f>.rb` and
  `brew audit --strict --online --formula Formula/<f>.rb`.
- Commit messages for bumps are `<formula> <version>`, which is what the
  workflow writes.
