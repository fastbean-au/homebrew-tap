# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippo_v0.23.0_darwin_arm64.tar.gz"
      sha256 "2ee7c7b13992382ea14bbae2d61243642bed081febe15079c0cf86345c3b8688"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippo_v0.23.0_darwin_amd64.tar.gz"
      sha256 "1db127bec5480f541216520c5ef1ff7bc09e08840d661b6a565c36221f34c080"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippo_v0.23.0_linux_arm64.tar.gz"
      sha256 "1271a43771cd6eaac8e7ed39ceaf899589cdfb8ddbd2d47a8c15f4601cd5cdcf"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippo_v0.23.0_linux_amd64.tar.gz"
      sha256 "0d99481c876e0c352bb75460312cee64fcf2492b76af092bb3e28bc1d8fa6158"
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
