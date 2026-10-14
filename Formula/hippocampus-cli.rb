# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippo_v0.52.2_darwin_arm64.tar.gz"
      sha256 "759898193ed9d684fedc1509cd80ecb3da6e820739b7b664f9575a61cf440d5a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippo_v0.52.2_darwin_amd64.tar.gz"
      sha256 "a04cde4ea7e8754f3acece53cca852057da9d0fab58fe26c0034bb4e452b2ed0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippo_v0.52.2_linux_arm64.tar.gz"
      sha256 "4490563de1583cc96a502c7cb51c0e20318e520bf9eb4d829996653835630194"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippo_v0.52.2_linux_amd64.tar.gz"
      sha256 "549f9475f3b9ef5986fc51ced19f9693a5315bc0434d8c138d8985a3f81e3d50"
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
