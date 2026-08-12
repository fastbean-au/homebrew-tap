# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippo_v0.29.0_darwin_arm64.tar.gz"
      sha256 "d6ff9cd28a144948d45604be585ccda7f5e1ab537c16b1eb71812a16a8e23cfe"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippo_v0.29.0_darwin_amd64.tar.gz"
      sha256 "acdb9fe7c19e23898b1a1cec83ea6895bcf602aa2d792cfb4a29ca5d33e1fc10"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippo_v0.29.0_linux_arm64.tar.gz"
      sha256 "305402a5c5c39815393e4faf8d5f100504c54bd8508a7c876effd1e9aa3aaa1a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippo_v0.29.0_linux_amd64.tar.gz"
      sha256 "9ba1b25f8e7e67b62eee8d358bc16fab360b72e44dbd57510a312bf292f867fc"
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
