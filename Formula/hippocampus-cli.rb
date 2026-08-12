# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippo_v0.28.3_darwin_arm64.tar.gz"
      sha256 "01a3c113a2b39b8e506fd375558cae9efed2a268601d0148e845fbfd61d8d1e5"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippo_v0.28.3_darwin_amd64.tar.gz"
      sha256 "6f5aeda2c45e6f24ef58e811fd7305f683f4136ce061f5e392aa572b12c765d9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippo_v0.28.3_linux_arm64.tar.gz"
      sha256 "8dc35114a0195f2bd268f0cfb4c389724a830c41e36b016a852fac2e62b98da5"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippo_v0.28.3_linux_amd64.tar.gz"
      sha256 "95637acb64a5d0a12bd1bcf82b27e6108fe2b79a8f1be612902140ec72061111"
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
