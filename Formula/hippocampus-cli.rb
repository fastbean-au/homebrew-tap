# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippo_v0.33.1_darwin_arm64.tar.gz"
      sha256 "36029472bef01dc32e853b7d08ab9f680654725fd71a86902e964815338bc376"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippo_v0.33.1_darwin_amd64.tar.gz"
      sha256 "3f1ca6096b7766c4884ef64e2bc415263ef7e6624272dff3d2cec0fda81dd2ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippo_v0.33.1_linux_arm64.tar.gz"
      sha256 "45001293a36b2364d8feaa91ab02b27f2cbd2e03b6a59a4e2fddd2866db71103"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippo_v0.33.1_linux_amd64.tar.gz"
      sha256 "993a80512b8047ae0505406803714f0636e16210339a624030a7efc3440a5178"
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
