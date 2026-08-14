# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippo_v0.31.0_darwin_arm64.tar.gz"
      sha256 "7fcfe80eaa81628da6fd398ea28e28d2b486442b09bd3df1ad14c85cc4ee3dbd"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippo_v0.31.0_darwin_amd64.tar.gz"
      sha256 "d5ccfceaecb80888a7ad8be2e40bb78340a9f09fe88bf78c4dda2e740dc16a3f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippo_v0.31.0_linux_arm64.tar.gz"
      sha256 "c74a2a86e0ba5ac87cb3b50a4d2420ce86754e773fd277500c0fabc1349eaf4a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippo_v0.31.0_linux_amd64.tar.gz"
      sha256 "fdb1e8196ae2667727c78ab6a2e3e010316891de64c50b9e915f2cc0b96c48bf"
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
