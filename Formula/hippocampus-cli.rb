# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippo_v0.36.0_darwin_arm64.tar.gz"
      sha256 "fe9c8afb87ad30c86926c7c5705b7663e2364e5432bed94a213268edc66cb115"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippo_v0.36.0_darwin_amd64.tar.gz"
      sha256 "399d2006a934f21d1ea0a1511ee148d16fbf9967b50edba0b8f2a1d48b9fbcb0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippo_v0.36.0_linux_arm64.tar.gz"
      sha256 "c03ae337a1191e827b1673b624be6e847c274d5ab960f2ed8e123af8761d0dd1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippo_v0.36.0_linux_amd64.tar.gz"
      sha256 "92db06f8bd7f9604099813f6080b012f034dd9eb0552edb9ff45cda6d8f76188"
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
