# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippo_v0.20.0_darwin_arm64.tar.gz"
      sha256 "e186bec4d2489d18b5b6a3ce4480ac0835c72f78585b3f466fa335083b038d4b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippo_v0.20.0_darwin_amd64.tar.gz"
      sha256 "78e48bdeaf326ebd4d0c5987bf0afc88e64206b45513c290e3591743148761f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippo_v0.20.0_linux_arm64.tar.gz"
      sha256 "39d884291fa317da319109547f422ba885ed9d3f9e62c4f77bbbadc263e801cd"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippo_v0.20.0_linux_amd64.tar.gz"
      sha256 "9245efd492da007bdf37d4fc081c08c576f55ac6de9419e42af677f828d20722"
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
