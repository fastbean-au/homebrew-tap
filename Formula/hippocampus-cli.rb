# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippo_v0.32.1_darwin_arm64.tar.gz"
      sha256 "fb60fd01ecff78574053c787079c2479b6f60a44dd7b24e816d3437eb4a1adeb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippo_v0.32.1_darwin_amd64.tar.gz"
      sha256 "49eeea17fca38880f4970444e3d7995b72c5bdf0887e4f4b8508247ca101baa3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippo_v0.32.1_linux_arm64.tar.gz"
      sha256 "20db3260283206f32cdce9b42c35c7154b862343e2c8c701cdcf8cea87cf26c1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippo_v0.32.1_linux_amd64.tar.gz"
      sha256 "faacd42db575d2e12a7439c582006715b93cbb71a84ef2eeed4eab0925907b6d"
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
