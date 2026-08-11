# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippo_v0.28.1_darwin_arm64.tar.gz"
      sha256 "399f1368d4bbdad2d3dd4c9f2b8b0bafe85151f9cfb46ecf5a8b6eb09b1533cf"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippo_v0.28.1_darwin_amd64.tar.gz"
      sha256 "49dc9b45eb5de3fc38f77c664746325e523d8e83c49af968960f0cfec73ac2e6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippo_v0.28.1_linux_arm64.tar.gz"
      sha256 "2e848b9b3eb59e470adcc34b37ad52483deb70b6308c6f59061c05457b25e5db"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippo_v0.28.1_linux_amd64.tar.gz"
      sha256 "1405f6ac98d1cccae01cc87c22cc29f879000b94c277445e0ef3d0072d0751fe"
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
