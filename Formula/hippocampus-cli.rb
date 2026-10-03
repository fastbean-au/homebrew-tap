# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippo_v0.50.0_darwin_arm64.tar.gz"
      sha256 "1e55fb72651caaa7546c8f683d27b05b08b2b0351d448973b453e2391e4f1fcd"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippo_v0.50.0_darwin_amd64.tar.gz"
      sha256 "03e7c31ae3212215339bc385a7ed0e73d18dd4ab5576f2e2efd83cabeac559c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippo_v0.50.0_linux_arm64.tar.gz"
      sha256 "0e63da2b9e6e0515fc265a4d04bffceb820e7c1d994af06a2245a185ea76dc7c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippo_v0.50.0_linux_amd64.tar.gz"
      sha256 "b809e4e3119b5abd87ba02ccde64b85ce682a15d9d65f10a331c95f588fff286"
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
