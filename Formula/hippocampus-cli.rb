# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippo_v0.47.1_darwin_arm64.tar.gz"
      sha256 "494d5a3d62681a85ccba51f707c301041b445ee55855dd191b243ab9df56e582"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippo_v0.47.1_darwin_amd64.tar.gz"
      sha256 "34100d898f1404b3deeb85a8b08f7b9f4fe6adb45bae390c6f9d5211f2e84eab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippo_v0.47.1_linux_arm64.tar.gz"
      sha256 "f44bf271e08b107c16c746b6fd0cb6eb00b5508f770e7ed295a0a2ddd0c1b0c2"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippo_v0.47.1_linux_amd64.tar.gz"
      sha256 "4390652a393dd94ea2549b241d42ccb146a2372a6ed37628b1fbb5bf3049f3c0"
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
