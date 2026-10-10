# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippo_v0.52.1_darwin_arm64.tar.gz"
      sha256 "f11eefe5b7883562dabcf441b3336d6844d74191548cdcf7308ce3b800192184"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippo_v0.52.1_darwin_amd64.tar.gz"
      sha256 "25c1a3338b14295cfe3297c86a68b2c6a38e50a34b05687474b88ff57d13af00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippo_v0.52.1_linux_arm64.tar.gz"
      sha256 "ec94813241187d74faf2f1126dc6dfc2a48b108737f308d99b07749eec7fb38a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippo_v0.52.1_linux_amd64.tar.gz"
      sha256 "d1b979edba1b0463bcb131a7696946f10c6ada0887d3a5e792a1d9da186359b9"
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
