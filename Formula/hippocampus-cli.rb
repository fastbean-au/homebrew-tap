# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippo_v0.38.0_darwin_arm64.tar.gz"
      sha256 "b03fc0a96287cfd05db91e7a569b125e06b7f91153d60017c5dc99c351f3802d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippo_v0.38.0_darwin_amd64.tar.gz"
      sha256 "be1031cc06d6d00323fb0552c9b9413b0f93d3a6771bfc6cfcce59f420856049"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippo_v0.38.0_linux_arm64.tar.gz"
      sha256 "c2bf6514746bae7ca882d0a252bda8648fae14dda696efb916fa14adae256d50"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippo_v0.38.0_linux_amd64.tar.gz"
      sha256 "d363ffcb5332d7b06dce4e0c4f7ad5f860bec1365cc417fee925aaf527956f32"
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
