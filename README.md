# jmcgarr/homebrew-tap

Homebrew formulas for my command-line tools.

```
brew install jmcgarr/tap/git-grab
```

Homebrew asks you to trust a third-party tap the first time you install
from it. To answer once for every formula here:

```
brew trust jmcgarr/tap
```

| Formula | What it does |
|---|---|
| [git-grab](https://github.com/jmcgarr/git-grab) | `git grab <url>` clones into `~/Projects/<domain>/<owner>/<repo>` |

Formulas download prebuilt binaries from each tool's GitHub release, so
installs take seconds and need no compiler. Homebrew downloads carry no
macOS quarantine flag, so there is nothing to approve in System Settings.

## How a release reaches this tap

Each tool's release workflow finishes by running

```
gh workflow run update-formula.yml -R jmcgarr/homebrew-tap -f formula=<name> -f tag=<tag>
```

with a token scoped to this repository. That runs `bin/update-formula`,
which rewrites the version and checksums in `Formula/<name>.rb` from the
release's `SHA256SUMS`, installs and tests the result, and commits to
`main`. The same workflow can be run by hand from the Actions tab, and the
script runs locally too:

```
bin/update-formula git-grab 0.6
```

## Adding a formula

1. The tool's release must publish one binary per supported platform and a
   `SHA256SUMS` file. The tool must have a license.
2. Copy `Formula/git-grab.rb`, change the class name, `desc`, `homepage`,
   `license`, the asset names in each `url`, the `install` glob, and the
   `test` block. Write the real release tag into each `url`; Homebrew reads
   the version from it, and the update script swaps the tag on each bump.
   There is no `version` line.
3. Run `bin/update-formula <name> <tag>` to fill in the checksums, then
   `brew install --verbose jmcgarr/tap/<name>` and `brew test jmcgarr/tap/<name>`.
4. Add the `gh workflow run` step to the tool's release workflow and the
   `HOMEBREW_TAP_TOKEN` secret to the tool's repository.
5. Add a row to the table above.
