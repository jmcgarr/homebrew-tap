class GitGrab < Formula
  desc "Clone git repositories into ~/Projects/<domain>/<owner>/<repo>"
  homepage "https://github.com/jmcgarr/git-grab"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.5/git-grab-darwin-arm64"
      sha256 "ba6c048ce5b819a47cd8d3a39f8d58da7ce91b45581eb7fc6b78649ea6655420"
    end
    on_intel do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.5/git-grab-darwin-amd64"
      sha256 "693479c3346a0211c925f092f1b97e4a6884494af1767889f85fc5df9cc67220"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.5/git-grab-linux-arm64"
      sha256 "8e8bc6cd0ed683674d79ab5d661e9ad560136b93426523dc40c1bbdacda3153b"
    end
    on_intel do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.5/git-grab-linux-amd64"
      sha256 "187de0eee7ec889cfae731ef22a3de4a5040e59ece80f9f1fd606f2d121988f8"
    end
  end

  def install
    binary = Dir["git-grab-*"].first
    chmod 0755, binary
    bin.install binary => "git-grab"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-grab --version")
    assert_match "cannot determine host", shell_output("#{bin}/git-grab --depth 1 2>&1", 1)
  end
end
