# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippo_v0.37.0_darwin_arm64.tar.gz"
      sha256 "eea2a4a687cea9024709cbeb18dfb23b114510829fc46e26e0fb736bf28fda08"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippo_v0.37.0_darwin_amd64.tar.gz"
      sha256 "f5fcdbf11f8aef46f4528883167ccef884eacdae93feca7d4da7ff4131f753eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippo_v0.37.0_linux_arm64.tar.gz"
      sha256 "a687545d087b0c131417d3375568a4fd462971b20faa5b4b1128022b32ba6ba1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippo_v0.37.0_linux_amd64.tar.gz"
      sha256 "e95d1747703ff5206d83f227fe4228fc28faa296e3a6a1df805a8e2bb6f30101"
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
