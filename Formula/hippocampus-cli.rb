# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippo_v0.52.4_darwin_arm64.tar.gz"
      sha256 "ce6ffe182256da859b085662d3b658c5b1bd6ae59c19d7708cf99b5a2216cbbb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippo_v0.52.4_darwin_amd64.tar.gz"
      sha256 "8ceb84dd87603d2ecda97d2e9ad0edb0e8b49dbcbe21f6b1bc16f58e215a5c75"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippo_v0.52.4_linux_arm64.tar.gz"
      sha256 "07ecb90634a8baabf204d19e66b66589a522be5ab4b2c5da4db80653dd3a48fe"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippo_v0.52.4_linux_amd64.tar.gz"
      sha256 "91a8f4ebfdf0c11c143c5fed8cf86429101cbc64647bd6a18a3a18d6368fd244"
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
