# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippo_v0.54.1_darwin_arm64.tar.gz"
      sha256 "26384ee766c3e885fd9138740d02618308f81b57c18d7b7707531e552aa0bb47"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippo_v0.54.1_darwin_amd64.tar.gz"
      sha256 "ef6ae0716a685d375cb3c6f399dd34366b2ebab578546804ed13eac0ecd5d0b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippo_v0.54.1_linux_arm64.tar.gz"
      sha256 "3c0aa069a2c964ee78f6194ea66d389bced8a8ed18e9d5c3614194dba721403d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippo_v0.54.1_linux_amd64.tar.gz"
      sha256 "85fc20b4223598ae4093c08c0c83176356da7a34b94c960993c9d7b72d70b5c0"
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
