# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippo_v0.54.0_darwin_arm64.tar.gz"
      sha256 "eaa71d2556916a7e85d1b08aa795d79abf756ec2cd922a42880752c790cb2308"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippo_v0.54.0_darwin_amd64.tar.gz"
      sha256 "ec6f3b214cb0f0729a7f306f239f24878e9a9d562fd58e55f442cf9867a1d1ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippo_v0.54.0_linux_arm64.tar.gz"
      sha256 "852697806189810e776d655ab3c91458c39f391d02b6306a196487b9e76e9d23"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippo_v0.54.0_linux_amd64.tar.gz"
      sha256 "542915efdc1e93233c71db6647b4c0a114763170be43d0efde27605b2dce1c5b"
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
