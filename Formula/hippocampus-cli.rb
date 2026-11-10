# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippo_v0.52.7_darwin_arm64.tar.gz"
      sha256 "4b89e14a4321766c7cd4007b4e6f1f5b5053b6681e4d701715bf209d1adbb43d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippo_v0.52.7_darwin_amd64.tar.gz"
      sha256 "6826cd96f44d40f17f97447dee5deab68edcbe69bd22fdeba6860f88c475d64b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippo_v0.52.7_linux_arm64.tar.gz"
      sha256 "107ec55001dcb9f6a2cc57d63772a3867d90c26038c56b6994fe455613253369"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippo_v0.52.7_linux_amd64.tar.gz"
      sha256 "49d5ab29ea497212a0568a49ba240901a3c1ccf3dcf890d659d7df29485b149e"
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
