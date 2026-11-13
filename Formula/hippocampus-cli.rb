# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippo_v0.53.4_darwin_arm64.tar.gz"
      sha256 "d7b05ba5e39366edf78a57dc510d5d634997a5763ba5f07d2f21c60c61c67e2d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippo_v0.53.4_darwin_amd64.tar.gz"
      sha256 "509b49651a2d3b70ac8f5e5f029dd6488a441065435bbd0f9a6168b2f213aa08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippo_v0.53.4_linux_arm64.tar.gz"
      sha256 "c73c49c2006fefe233770b36503dd7f01a38877a53b6210493fb3975e1baa720"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippo_v0.53.4_linux_amd64.tar.gz"
      sha256 "2ecda8a238a1e6812db5991f127cca5276e2da40f6380a83763d38a7d2d1eff7"
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
