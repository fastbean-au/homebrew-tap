# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippo_v0.52.0_darwin_arm64.tar.gz"
      sha256 "c2370a773ebed8e7570b7168192fc63cca6aa1b8ac487c10f317e6bb60295e48"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippo_v0.52.0_darwin_amd64.tar.gz"
      sha256 "14ccf8c1ef9bd0900f48a7df9a7bc90971f6339a771728619303c5895cef3de0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippo_v0.52.0_linux_arm64.tar.gz"
      sha256 "d3ee53b686a450fbde9c4b2b39a2923742d899f1c09f7a98c2b298f12b5372ba"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippo_v0.52.0_linux_amd64.tar.gz"
      sha256 "0537c3fe4e513b5e973b075db5ba89ff2f885ab566b9a272aced1fab9bb133ab"
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
