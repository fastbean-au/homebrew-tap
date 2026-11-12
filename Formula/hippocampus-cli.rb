# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippo_v0.53.2_darwin_arm64.tar.gz"
      sha256 "b4b73731fd2ee983701444b3f667527ca37eaf500e0e7681e207a53a540ed9e3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippo_v0.53.2_darwin_amd64.tar.gz"
      sha256 "fb920f1b020567843f3411d95b3f013ffd1ccdc2b22571ebbf418a2fc61831ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippo_v0.53.2_linux_arm64.tar.gz"
      sha256 "5e95e62624259fea593847593ce193db48ac65ec12ba76876fdd15132257b01e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippo_v0.53.2_linux_amd64.tar.gz"
      sha256 "f0eef59889b718e016836a6d4e24f8decc31b41bd6573522f1dcd002ab97513d"
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
