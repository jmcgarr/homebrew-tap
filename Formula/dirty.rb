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
      url "https://github.com/jmcgarr/dirty/releases/download/v0.2.0/dirty-macos-aarch64"
      sha256 "98c959c1a9761b44e8162706152e428f9520044db980eec6738f71edabc17a40"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jmcgarr/dirty/releases/download/v0.2.0/dirty-linux-x86_64"
      sha256 "08b28bf3e7b6f57a9f9cc290ec5a0a8c4d3fe9f6475efd5bf86632477a40b77e"
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
