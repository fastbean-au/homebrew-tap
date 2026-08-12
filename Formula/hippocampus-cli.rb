# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippo_v0.29.2_darwin_arm64.tar.gz"
      sha256 "bd308a400be4efdd17ac1bbc1cfde465385679bd6562c0f037cd62e2e6989c7c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippo_v0.29.2_darwin_amd64.tar.gz"
      sha256 "2d084bbceb346b31ef1555545d410fb50881fa7e06d0803dd6f3287d1e9f24ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippo_v0.29.2_linux_arm64.tar.gz"
      sha256 "4f2ca1806f0db545276fc9dcb4cc7eb381c18b6f1c9d8d16b9db379251920858"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippo_v0.29.2_linux_amd64.tar.gz"
      sha256 "6740ef933761ce4e6cdbdc9fcae95233af88be618f98dd789bfd18e045c3ef98"
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
