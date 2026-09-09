# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippo_v0.44.0_darwin_arm64.tar.gz"
      sha256 "3a3924e401d39611975012c6918ffca9de63b4d0f050c6c4c0c0186ce221a76a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippo_v0.44.0_darwin_amd64.tar.gz"
      sha256 "72379b6f79118c849832b9d35ec4932f75abe82479bf73f30bd421004468f3b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippo_v0.44.0_linux_arm64.tar.gz"
      sha256 "8c9a4b88ea51042fe847aa619a68b8221eb27c83b28d05f992eedc315d2bf3e3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippo_v0.44.0_linux_amd64.tar.gz"
      sha256 "863b7d90e2bef094ddca5bfa8d85ad0bc9154600cd8526fcd6aceab7d3fdf8a7"
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
