# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippo_v0.48.0_darwin_arm64.tar.gz"
      sha256 "a55085a43ddf5067e00302819bb1959ab0c37bb80f1d3871d7694b341ae6a472"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippo_v0.48.0_darwin_amd64.tar.gz"
      sha256 "6b654b507eab1913d775d25b71ffa8c2df8b534ce01ab8ed021a0330bf58ed62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippo_v0.48.0_linux_arm64.tar.gz"
      sha256 "1db327954322caf5acf0a44cc9d9e51fbeb13f88bea94208b5feba9e4678d599"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippo_v0.48.0_linux_amd64.tar.gz"
      sha256 "aa17d507bffb6e215d93197eaaa3988104b50fd404e296b5b236e2de2f70dbd7"
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
