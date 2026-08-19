# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippo_v0.35.1_darwin_arm64.tar.gz"
      sha256 "35f75769ca3debf4094ffbca941a20fc18ef4a484da21c399a3a058bf7945543"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippo_v0.35.1_darwin_amd64.tar.gz"
      sha256 "cc51575c17c0905ef8649e63a7430701db988aeb5abf14f14f225029b19a7585"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippo_v0.35.1_linux_arm64.tar.gz"
      sha256 "ceaeba7a2842e4bee4d8e36e20ec873489364bae8c4a0273878055663359b31f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippo_v0.35.1_linux_amd64.tar.gz"
      sha256 "79116bbf2b01a60626f4347498889a97b4ec72a4d32b3322555c31f4529e1a6e"
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
