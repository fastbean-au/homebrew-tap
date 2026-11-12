# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippo_v0.53.3_darwin_arm64.tar.gz"
      sha256 "49eea64c4c9999c4dd24bb269caa1edc795a6147d61694acbd083f0c9dd32444"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippo_v0.53.3_darwin_amd64.tar.gz"
      sha256 "059dc427b196e0ab14821442557fc0a01b3e87e62aa907bd984ce4c02a51a196"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippo_v0.53.3_linux_arm64.tar.gz"
      sha256 "f27f50c851a68153e50374ef79655671061eecb6767b06705d4303b249cd788c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippo_v0.53.3_linux_amd64.tar.gz"
      sha256 "61e01022e7900d07e21edf39cbabc1b666b35aa77b9dfa2c756f8238037876b7"
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
