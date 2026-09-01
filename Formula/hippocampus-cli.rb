# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippo_v0.39.0_darwin_arm64.tar.gz"
      sha256 "97692047fa8e3fc823cb7345d52921575a16b1cd45f7e7d6a5eb08f0da3971ab"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippo_v0.39.0_darwin_amd64.tar.gz"
      sha256 "6e99e7e572c6893e22fdcaff6b2a16e93bdea8598f937d16879b410ac037bc81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippo_v0.39.0_linux_arm64.tar.gz"
      sha256 "a8b88853699eb4d9d54f525753f9c5f3a9278037fb30cf02cea4ae0267126d0b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippo_v0.39.0_linux_amd64.tar.gz"
      sha256 "2d159e95e1f22d65110af024bc9aca448ae30bc63298d22cd5cf0aabd194e56e"
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
