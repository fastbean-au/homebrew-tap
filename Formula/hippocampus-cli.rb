# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippo_v0.21.0_darwin_arm64.tar.gz"
      sha256 "d79a8dec89e04d076375878d24fe9e9364a93a1940cf31378f4d982d5530ea0e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippo_v0.21.0_darwin_amd64.tar.gz"
      sha256 "37ddafeb2d9add6b2a2128d08336e79a23aac44740930f0187d9e6dadc27c9d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippo_v0.21.0_linux_arm64.tar.gz"
      sha256 "e87c6212dde99dec5e1e085cdf14393b53119678bc6ce65744ac937ace13e145"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippo_v0.21.0_linux_amd64.tar.gz"
      sha256 "a42e58151f483e4247fde186a3bca13514080683bfd7850e86e1391897ee9fb2"
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
