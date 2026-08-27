# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippo_v0.38.2_darwin_arm64.tar.gz"
      sha256 "19427236dbbf0dabdf77ff5652c2050be5956e72742531aa1ff86a26a01d7715"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippo_v0.38.2_darwin_amd64.tar.gz"
      sha256 "e702925ae619a8660974a1af2598e86a5e92ead2a49a2dda03272b42e88ea4ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippo_v0.38.2_linux_arm64.tar.gz"
      sha256 "553c9c78a177265287467c48d5f28f865899223389005db05b39be6c4ad59bcb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippo_v0.38.2_linux_amd64.tar.gz"
      sha256 "3479a049aed423df6515f2362b502ef2707b88866f9e841f5c824775f5ecd052"
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
