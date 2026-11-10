class Dirty < Formula
  desc "Find git checkouts with uncommitted changes, untracked files, or no remote"
  homepage "https://github.com/jmcgarr/dirty"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jmcgarr/dirty/releases/download/v0.1.0/dirty-macos-aarch64"
      sha256 "38c29bc7cf90112091c997913368554402d2ab1aef1cd509fb350d5339b5130b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmcgarr/dirty/releases/download/v0.1.0/dirty-linux-x86_64"
      sha256 "ae83e67a7b323ab68f7126a1d8dc7e4a9342dd498902e1a30591772c243c8b35"
    end
  end

  def install
    binary = Dir["dirty-*"].first
    chmod 0755, binary
    bin.install binary => "dirty"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dirty --version")
    # An empty directory: banner on stderr, nothing on stdout, exit 0.
    (testpath/"empty").mkpath
    assert_match "Finding dirty git repos in", shell_output("#{bin}/dirty -d #{testpath}/empty 2>&1")
    assert_match "Not a directory", shell_output("#{bin}/dirty -d #{testpath}/missing 2>&1", 2)
  end
end
