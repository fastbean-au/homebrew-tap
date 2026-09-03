# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippo_v0.40.1_darwin_arm64.tar.gz"
      sha256 "3199c9bd60681fce1d55ffd577af9f7a5f90bd3ac8c4ba2d4f13b54d3179556b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippo_v0.40.1_darwin_amd64.tar.gz"
      sha256 "7575fba5b70412b28b68fa2aefba5bb294bab4a03de007b24d2576a5fe72346b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippo_v0.40.1_linux_arm64.tar.gz"
      sha256 "e5c3f666038cfded3c86529f4b39be818cfea2271d850fe5c9d9846678a569c2"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippo_v0.40.1_linux_amd64.tar.gz"
      sha256 "3ef66f20d2e29c1f55689aba67404432b56b2b89f92435bf8ed3a62431823013"
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
