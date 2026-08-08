# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippo_v0.26.0_darwin_arm64.tar.gz"
      sha256 "e7b350de7b3679ac0da87f6e62468b7d21f696c2b871a10364ff818ed86a0007"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippo_v0.26.0_darwin_amd64.tar.gz"
      sha256 "cb578bc5a6de5d043a766cfe10b10ea667baa16ef9d7f63d6814f646fbfe185e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippo_v0.26.0_linux_arm64.tar.gz"
      sha256 "e94a5a1ee2d5759caf1e23406d4a66024964d6281984b65ad77348cade760237"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippo_v0.26.0_linux_amd64.tar.gz"
      sha256 "e6a451d1a1e0d156d34181a6625f4c5f767bf18ad107c3e963e9ff9cc725f083"
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
