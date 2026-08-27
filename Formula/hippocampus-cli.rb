# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippo_v0.38.1_darwin_arm64.tar.gz"
      sha256 "5f04f556cd42cca24c9d25038a2b54b04da4c2b43bfec777da9a1e82b17af77b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippo_v0.38.1_darwin_amd64.tar.gz"
      sha256 "7e1c9a5deab26d0f3113a9f30e8912ff57a1001302f3238176fa60973f31356e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippo_v0.38.1_linux_arm64.tar.gz"
      sha256 "6cddd83ab9b0cd8db5470e8b383ef7bbc6f5d88fb9e101ce5488c19489978a1b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippo_v0.38.1_linux_amd64.tar.gz"
      sha256 "1d934ae97ea8277394e7499937315f0cc9e06574c59bd6c5339552f255a988aa"
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
