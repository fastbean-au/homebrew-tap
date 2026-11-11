# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippo_v0.53.0_darwin_arm64.tar.gz"
      sha256 "c92bf73ef745b70da1338080c1fea779648f7acb445a26126317126fa433fbdc"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippo_v0.53.0_darwin_amd64.tar.gz"
      sha256 "dfc4eff4adbfe7839bcca3dc0d6b23ba3a4cf21dbd51aa8cdf981c2f5b68e71b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippo_v0.53.0_linux_arm64.tar.gz"
      sha256 "4fad658c5faba837dfd1f5a1e4286317cc7fb49966e11215a57a8cf97f919039"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippo_v0.53.0_linux_amd64.tar.gz"
      sha256 "22338b16a07b4188320f8e08fb758c7365d119478f397cd336510daa29b3c092"
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
