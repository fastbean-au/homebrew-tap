# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippo_v0.29.1_darwin_arm64.tar.gz"
      sha256 "41b109995c3edb508795626470e51c532531e52257864873800b048c34d25391"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippo_v0.29.1_darwin_amd64.tar.gz"
      sha256 "17af3159db09b23d108339e3ffc8065e811411059a7e7e1cec9c60ed44ae986a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippo_v0.29.1_linux_arm64.tar.gz"
      sha256 "fffc19b9ae7800f73f5da4f6b510e89781e19c71be6ab8163596c18cc1d12d78"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippo_v0.29.1_linux_amd64.tar.gz"
      sha256 "f58322afcd952592d02d8da9e5b546f7295a94824539a7f3efcbb716befe30ed"
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
