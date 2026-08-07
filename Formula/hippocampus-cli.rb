# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippo_v0.25.0_darwin_arm64.tar.gz"
      sha256 "2ff3d6bc85ef7a5efc9a6a385d131cbc87318b503fddb8147b61ab551facf7cf"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippo_v0.25.0_darwin_amd64.tar.gz"
      sha256 "5a2f1a160838f6dc6d550a065047045ab13c48f268983bc3e80501ccd562e95a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippo_v0.25.0_linux_arm64.tar.gz"
      sha256 "204f0d7601f69c5634d744a7780eb509b60a7d58e1050ae576be57614a2b9fb9"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippo_v0.25.0_linux_amd64.tar.gz"
      sha256 "c444128a9963d3d3de73a5ac5011aae3757d7ba983ac8435dac8ca5c8a695a78"
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
