# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippo_v0.42.0_darwin_arm64.tar.gz"
      sha256 "8691233f49c014849f78fd09ff531eea05959517332d7fce75a899988fbe9b11"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippo_v0.42.0_darwin_amd64.tar.gz"
      sha256 "f94f4558c8b0dfbee32e727af7d86d1bf7a48792097e3c2620d4317b3eb27674"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippo_v0.42.0_linux_arm64.tar.gz"
      sha256 "c7e76a59d1639cc86f3bccf6f7e2b729e2cb2744e35298e6eaadb03166ed30f1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippo_v0.42.0_linux_amd64.tar.gz"
      sha256 "41c11bf1a18ef26e75c1ebb59ff7cf8ced9e220a2ee50dcde6f950c385db124f"
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
