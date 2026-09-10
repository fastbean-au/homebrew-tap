# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippo_v0.46.0_darwin_arm64.tar.gz"
      sha256 "a8026e401bb1d1173fb0a825b0198023e52bc7763b4554d84eb2e03ff3f2515b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippo_v0.46.0_darwin_amd64.tar.gz"
      sha256 "a1079d51b2de63cfdc757d6db47f7760e59a19c1cd351d07963ccc8e7e818ba6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippo_v0.46.0_linux_arm64.tar.gz"
      sha256 "fb5c033ddcc0ddc05c5778a5f3a91b57e692976079b6d9b6e653e472422f5d1b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippo_v0.46.0_linux_amd64.tar.gz"
      sha256 "02d8c07188639d6b7c724c87ec2fe5c69400969a7d61b4319e275c896d66379f"
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
