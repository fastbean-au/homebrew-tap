# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippo_v0.53.1_darwin_arm64.tar.gz"
      sha256 "d1e84c89290ad04c75aef2c7935132635d29e07a896e9165e40c1bde82587e99"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippo_v0.53.1_darwin_amd64.tar.gz"
      sha256 "316a1f42cb91c2303ce0a42305c1c140ccce7d9b60dc689a916b6efa9225588b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippo_v0.53.1_linux_arm64.tar.gz"
      sha256 "d8bff4c58b95a153e864d816b3b7c03c4d362907be39896b15d113d175522318"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippo_v0.53.1_linux_amd64.tar.gz"
      sha256 "666bae3dcd6938f1a3fc13c87e92a4c051167591ba9532dd1f6e5c25b2068028"
    end
  end

  def install
    bin.install "hippo"

    # Shell completions are emitted by the client itself (`hippo completion <shell>`), driven off the
    # same command registry as the CLI, so they never drift from the command surface.
    generate_completions_from_executable(bin/"hippo", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hippo --version 2>&1")
  end
end
