# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippo_v0.28.2_darwin_arm64.tar.gz"
      sha256 "72d24dc4d24022b2e903ef75de4225cb19bb9b92d45aeed7f8f997d1ecd69daa"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippo_v0.28.2_darwin_amd64.tar.gz"
      sha256 "3af929bcfa0d14eefd763488781b49aea6c7ab45c9bf71c5e4d426e2d3bbfa1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippo_v0.28.2_linux_arm64.tar.gz"
      sha256 "02c8b6deadd1349412e861ca12dc22e972d1088eb41e405437fcfbe27a9e240b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippo_v0.28.2_linux_amd64.tar.gz"
      sha256 "5fe945f127494783214d7bc774fdf71c53f9825a8aa152896d23c98b4f9d44db"
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
