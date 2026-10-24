# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippo_v0.52.5_darwin_arm64.tar.gz"
      sha256 "fef6205eacee3a66f841db40d20f0a9c6e83a5fb771034b7f5f0f332176526e6"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippo_v0.52.5_darwin_amd64.tar.gz"
      sha256 "5d428dc81eb5f8c611876cd7e434e4e8c3152f6cf843e9a24bac90c1fe9cbd15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippo_v0.52.5_linux_arm64.tar.gz"
      sha256 "9a5d6085582b959a2882163245516135ceb3c90b213bc0705115ef455653c56f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippo_v0.52.5_linux_amd64.tar.gz"
      sha256 "387641975483087fa5c832d7f660ed5e2ff78a3eb896adcb30a5525f37dc83d6"
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
