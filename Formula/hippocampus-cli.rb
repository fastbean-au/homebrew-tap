# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippo_v0.52.6_darwin_arm64.tar.gz"
      sha256 "6dcfe104cd35267a5991ba679dfba32e4923bee6ac3610a4ac10e0d78c0c8d51"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippo_v0.52.6_darwin_amd64.tar.gz"
      sha256 "655438ac1a8f6caa088b58fdea080f700bc4e90ca58014822371ab4afb982f9f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippo_v0.52.6_linux_arm64.tar.gz"
      sha256 "9969cd5a17044fc99a33d48217d319c46e2c8966060a7bfe9b1c87f654fee622"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippo_v0.52.6_linux_amd64.tar.gz"
      sha256 "8c82b1d294eb610c8f081a344ec6feb49a6a929bbe733b1c7847791be18b07d2"
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
