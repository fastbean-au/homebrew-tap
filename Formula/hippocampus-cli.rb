# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippo_v0.35.0_darwin_arm64.tar.gz"
      sha256 "61dc8d7725a972566dc732a607a0d7c6b22cde65b1a45eb1df40c02870f730c4"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippo_v0.35.0_darwin_amd64.tar.gz"
      sha256 "f4d930217544cc52a70ff855fd7af27b74589ebb9fa92283a372cb37dae946bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippo_v0.35.0_linux_arm64.tar.gz"
      sha256 "49fe40351bb2090b92093683e2ac78d6f7526ef8c40feddd6bd4afa8c5b11f59"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippo_v0.35.0_linux_amd64.tar.gz"
      sha256 "6967d99ca2af1d3544dae8cbc6d7b2e0d323fd09d34a61c587a4c97874c53c82"
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
