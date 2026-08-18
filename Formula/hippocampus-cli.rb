# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippo_v0.34.0_darwin_arm64.tar.gz"
      sha256 "a963ae5cfa8a0841b809ba43feb1092d628bea4d0248fd288936e11f6c94a94b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippo_v0.34.0_darwin_amd64.tar.gz"
      sha256 "0b932933dc0889740920d7abdf97dbef6e8e0ed9bf6c849865c23876b708e754"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippo_v0.34.0_linux_arm64.tar.gz"
      sha256 "46f4cebb183d69a5d0fbb858118b8d020bb6ddfd14b85eb33dac274be858ab77"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippo_v0.34.0_linux_amd64.tar.gz"
      sha256 "1d06560f982b6f142f16c63a9e9012b50e22e4f75e4d766d63dcba1e719d0125"
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
