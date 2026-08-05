# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippo_v0.22.0_darwin_arm64.tar.gz"
      sha256 "4a9080f1a0522ac1be0a289c42875f1d8e70feadcd6467899978a47d172c2799"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippo_v0.22.0_darwin_amd64.tar.gz"
      sha256 "bcc46b98a292c693633fa4b9f86870a2a4f18c1d23401541b0f36bb4f517fbec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippo_v0.22.0_linux_arm64.tar.gz"
      sha256 "b1083c8b47e2087d64d61da4cb0d5a026fc47932eda58bc2c8d0ed6636300b8a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippo_v0.22.0_linux_amd64.tar.gz"
      sha256 "87f3b44cd045e3ca9648e9b9b20884c0d70f7f1b7a2ab547b45eecac1dabd0f5"
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
