# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippo_v0.27.0_darwin_arm64.tar.gz"
      sha256 "2fd906c0267e65d6451e12c38bac06f616698c3cd23573f0658af725bf475e6d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippo_v0.27.0_darwin_amd64.tar.gz"
      sha256 "ec1d6e4111063bf7caf9b3a652f6133e7e208ddc12764fc2c9e9cf4b053262c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippo_v0.27.0_linux_arm64.tar.gz"
      sha256 "0963b9412dd2e643cb453d324d035376b2082d9fead6edf40f610f78694ea50e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippo_v0.27.0_linux_amd64.tar.gz"
      sha256 "2d6993a480b82038054f475f8e63c8f1b629f5107ae3957b3566b433734dc373"
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
