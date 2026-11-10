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
      url "https://github.com/jmcgarr/git-grab/releases/download/0.6/git-grab-darwin-arm64"
      sha256 "24135d53779d07f8d7bec5a55ab5a2d7775dba25c53a93b24140ea5357d1073b"
    end
    on_intel do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.6/git-grab-darwin-amd64"
      sha256 "e9bc2d087cbfecfc09b889f21ca253bae772a312308e9ab00eccf0e2eec6cc7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.6/git-grab-linux-arm64"
      sha256 "7f5df1d88aa8eaf4b5201bc618ec1c9b39e809bbf840ad17d3fd40f0c2f85929"
    end
    on_intel do
      url "https://github.com/jmcgarr/git-grab/releases/download/0.6/git-grab-linux-amd64"
      sha256 "076efbecc1573b42c60cde79e7b91b43c8fbe9c08a6a6e508c8cb3f1b3786165"
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
