# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippo_v0.40.0_darwin_arm64.tar.gz"
      sha256 "53be818773b0a944fd2beff485f048a41aa625a96e1c6214c2c47e8c19039f27"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippo_v0.40.0_darwin_amd64.tar.gz"
      sha256 "2054aadadd15166a95eff9a68f88e5a3b9bdca8f55a64aa3ba1a701a274b2827"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippo_v0.40.0_linux_arm64.tar.gz"
      sha256 "90799a455b1c545712f51cbe2b9404439b2df8c88a0357f0ee8b9ec2addf6a62"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippo_v0.40.0_linux_amd64.tar.gz"
      sha256 "c0b9010fd9c07f652f5c9a0e9edfb81224db524aac795b1eb28258d33a51c460"
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
