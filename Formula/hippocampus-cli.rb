# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippo_v0.51.1_darwin_arm64.tar.gz"
      sha256 "8a3062c13614574db36b0ba7a96beaf022179c3d17a6d385ce15908c0997e78c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippo_v0.51.1_darwin_amd64.tar.gz"
      sha256 "cf0d58a6adada97351d2ae66d688b46b359940941541171a1c28a80805cc693d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippo_v0.51.1_linux_arm64.tar.gz"
      sha256 "19bb2556300ac3916537d11e7497bba1a7e77603fc71a8438987ee099bcac814"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippo_v0.51.1_linux_amd64.tar.gz"
      sha256 "b2d126a703fbe05c4aa235684a89a8121f766658c56300fc444e61df7230c6fe"
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
