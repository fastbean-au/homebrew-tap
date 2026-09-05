# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippo_v0.41.0_darwin_arm64.tar.gz"
      sha256 "c0bd875fea7cae2dd0aba301998f3fa44b7b087aabff1a275592020ddc4809ee"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippo_v0.41.0_darwin_amd64.tar.gz"
      sha256 "15ddc227b69e38a7564a27d7d3a8b9bf8d26d05e0da8f1a63a59cc009f6ce1b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippo_v0.41.0_linux_arm64.tar.gz"
      sha256 "40f216707b8d8e164242a89573ff0ccd87afc56595c3ea278cd113b600b1b791"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippo_v0.41.0_linux_amd64.tar.gz"
      sha256 "1e855de8084c43e4ba8d738e8aeb0252ceb44982db7816b190d4952fc317110a"
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
