# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.45.0/hippo_v0.45.0_darwin_arm64.tar.gz"
      sha256 "a99e042b51e128697ac4c4108f6f2bc4918e6cc16401b026c8a26f1936e974ee"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.45.0/hippo_v0.45.0_darwin_amd64.tar.gz"
      sha256 "4c98e198fe70a44abaa5ea47343941f1f956fab3104bf4dc510696826445a5ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.45.0/hippo_v0.45.0_linux_arm64.tar.gz"
      sha256 "619341eadf9e234b03c06107d15ddd47df8e20ad0e5ce99529ce54fa27d571ff"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.45.0/hippo_v0.45.0_linux_amd64.tar.gz"
      sha256 "eba10fa102368dd5b95cf10ff9b7891ebc78bfc464b19048a86f458b7d865886"
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
