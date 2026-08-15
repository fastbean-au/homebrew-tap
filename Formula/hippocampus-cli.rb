# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippo_v0.33.0_darwin_arm64.tar.gz"
      sha256 "f48485cef25b21f6269afadfc0adb4e2bbda6d62d6634b463797163a36acf1ee"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippo_v0.33.0_darwin_amd64.tar.gz"
      sha256 "3e6ff842e5c5165c33e2052e187369eabecfe8d5d10cfdea7be48bba9e254c7c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippo_v0.33.0_linux_arm64.tar.gz"
      sha256 "7f21fedd2fd37d9a4092096eee53cca9beeeb4d439d03d254f2e44328f411f2c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippo_v0.33.0_linux_amd64.tar.gz"
      sha256 "40741579e3fefbdc04d615ba6d316f35797936a82c2ff24f1ca77d2b6536272d"
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
