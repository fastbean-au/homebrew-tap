# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippo_v0.47.0_darwin_arm64.tar.gz"
      sha256 "a537137df3b8ffc304abdfab9dc16982616c7c448330c89483d383fa77503fd8"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippo_v0.47.0_darwin_amd64.tar.gz"
      sha256 "b72fbae68c1e6a2e539e1a0b48ebb923afabea5401555002ad788a03e4ffb743"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippo_v0.47.0_linux_arm64.tar.gz"
      sha256 "ea69d59b51210926f72228a1b10e980712d501dd75fc016044107c622a3b7f96"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippo_v0.47.0_linux_amd64.tar.gz"
      sha256 "ff6048c6c3ef87cfad99928e84eedf88e983978eb9e38969f48b7fd518070416"
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
