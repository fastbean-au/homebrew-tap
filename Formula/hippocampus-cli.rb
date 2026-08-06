# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippo_v0.24.0_darwin_arm64.tar.gz"
      sha256 "a1da8f2737c2e2343599d803e4cb80455cb10f3939f7996cf1e9995dc1e012b0"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippo_v0.24.0_darwin_amd64.tar.gz"
      sha256 "1eccdcabb9fe0bfba54821ab0c5a2d59c18250a4098f9333b4916835ec8de7a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippo_v0.24.0_linux_arm64.tar.gz"
      sha256 "1b446028b97b79ee23c336f10c702de14eb08198febd24d516da05e0504f1083"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippo_v0.24.0_linux_amd64.tar.gz"
      sha256 "5874e802f2dc98cfdd4e8658caa44ba8ccb650e9d134742c5d56257e37a0b4e7"
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
