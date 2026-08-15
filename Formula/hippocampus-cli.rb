# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippo_v0.32.2_darwin_arm64.tar.gz"
      sha256 "3639bd3d4550fb1765d0229fc07ec003b4bebee23014b7fc66a0219979d36e69"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippo_v0.32.2_darwin_amd64.tar.gz"
      sha256 "f7eb4612cee7138d6f618bdc9e217bcfc558399f8cf2230f4f5763c0f0144d2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippo_v0.32.2_linux_arm64.tar.gz"
      sha256 "6f3b17d804f39957b1cdfca7e8cfd77aee64bf2d3d9c556a0b86546a0c571162"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippo_v0.32.2_linux_amd64.tar.gz"
      sha256 "1fb0bdfaf9ab0b8cf46e5cf32fb099f913c1961e0ebb7ecffa4b9e9f1835e9f4"
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
