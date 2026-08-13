# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippo_v0.30.0_darwin_arm64.tar.gz"
      sha256 "c1aaf9ca9b901ba350bc8acd314e90eadc26a02d9d006c8a670983da20842bfe"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippo_v0.30.0_darwin_amd64.tar.gz"
      sha256 "a3e0e5f9affeb3b972312a82353f0dc8b21591e6b10aea5436b8d8c443698f51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippo_v0.30.0_linux_arm64.tar.gz"
      sha256 "844d155a575d3e1451c1d467f68e343d7176d313962cc6e3d2c286f18c789652"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippo_v0.30.0_linux_amd64.tar.gz"
      sha256 "2f2465c04f2602962e1289a56493b7c20823ffa82c3789c97010384c5f75fc42"
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
