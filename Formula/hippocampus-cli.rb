# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippo_v0.38.3_darwin_arm64.tar.gz"
      sha256 "954df45c0244fcfa0de36a860ead824f74d56f03b81346e51684f651fb59869c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippo_v0.38.3_darwin_amd64.tar.gz"
      sha256 "8ee1d40b4d6720ca2b5f4f227f467d78701dea7385587189978ff8c377a9d782"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippo_v0.38.3_linux_arm64.tar.gz"
      sha256 "75234fecd651a29473a22ba27c2e13f8a54ec6ec29e0177e1f199071dcd35354"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippo_v0.38.3_linux_amd64.tar.gz"
      sha256 "c7a2f208ca2673102ac7146d5ff81fe52cf3b22304acf7620363b143cd3f0370"
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
