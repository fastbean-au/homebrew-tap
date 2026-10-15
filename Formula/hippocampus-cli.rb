# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippo_v0.52.3_darwin_arm64.tar.gz"
      sha256 "1b35607dd3b22fe2ed3c5ef5afd23b16716342100a82556365592d58d1f42cac"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippo_v0.52.3_darwin_amd64.tar.gz"
      sha256 "bdf26c7b99ddd2bbc34c1a8c2d06f5c63a41c50ac4c21cab8a8a0b9189567b1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippo_v0.52.3_linux_arm64.tar.gz"
      sha256 "4e1f0c114c7902b1b71f2618385853b49c088c72bbab07a1d5139cb3933d26ad"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippo_v0.52.3_linux_amd64.tar.gz"
      sha256 "b29eb2153c5e1ffba05e5a900e345a55cf0a23f34f8b5442140d4c189a80d729"
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
