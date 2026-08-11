# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippo_v0.28.0_darwin_arm64.tar.gz"
      sha256 "81f87459432394e9e256159ef4aea56b97134fb72a8100b2fd59a0992f66f5f3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippo_v0.28.0_darwin_amd64.tar.gz"
      sha256 "27b3cffecc3d8ca1b1f2a9ef7c6b4c4b74866f3d91af72b0a78f770ad4b07a82"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippo_v0.28.0_linux_arm64.tar.gz"
      sha256 "dd08a902ad08742f7413bf44310a412aed07f89327aec59ad0979b1058825e30"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippo_v0.28.0_linux_amd64.tar.gz"
      sha256 "3539e49a0fbe2827627ee3d45454c7605095525af7e6bf12d03cfe532b29111e"
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
