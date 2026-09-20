# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippo_v0.49.0_darwin_arm64.tar.gz"
      sha256 "da1eb8e855ed70b73be63de95170179e60aabc742c90c1fd0a6c193e41474edb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippo_v0.49.0_darwin_amd64.tar.gz"
      sha256 "143710ce1f1935c94cf4e90be212e13be944a4ea9c69671cb9c1ae02741086fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippo_v0.49.0_linux_arm64.tar.gz"
      sha256 "89b0ec6765207cf3bc0615a2d0f15324e2f2b92e2bb779e72869a09a53549644"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippo_v0.49.0_linux_amd64.tar.gz"
      sha256 "7c730a71ace9222455b2ceaab1a6d33dbf7e8c34fe0499ef7a282c452180d5be"
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
