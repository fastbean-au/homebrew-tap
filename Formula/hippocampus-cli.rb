# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippo_v0.51.0_darwin_arm64.tar.gz"
      sha256 "dd028c1f67501345e41cf2bca6c9e2b03fcce178138221cf64edd792a6ec7497"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippo_v0.51.0_darwin_amd64.tar.gz"
      sha256 "1c97d658ed497c8dd6e44efc15ca82c70471ee1603429135b722c98630a60b4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippo_v0.51.0_linux_arm64.tar.gz"
      sha256 "9a586c1f2b59764be6c7fc480534ffbe5fb843ae6db279cbbb3700547cf03434"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippo_v0.51.0_linux_amd64.tar.gz"
      sha256 "063788f51003e05956e204771de344ed51ae3b705d7175a63bcbc7f3dc9df506"
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
