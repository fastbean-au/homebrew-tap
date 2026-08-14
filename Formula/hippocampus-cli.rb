# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippo_v0.32.0_darwin_arm64.tar.gz"
      sha256 "89df8672323b68b299c1431696e1779a9f19dc6eb8ffa925dbe15b4033664072"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippo_v0.32.0_darwin_amd64.tar.gz"
      sha256 "ddc244255f581bccc9c04f676ebdb479c42fd643d58bdb3e0bb80099755955c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippo_v0.32.0_linux_arm64.tar.gz"
      sha256 "effbf15c213ab3d839a38b4ad81b5ad4e2a843e82643959903209b9de7462b0b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippo_v0.32.0_linux_amd64.tar.gz"
      sha256 "d5dd855f652894ed2e8051cbc6b519fdfc53f7bb6e8336c6e5bd628430fd87a0"
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
