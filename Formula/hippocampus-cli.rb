# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippo_v0.28.4_darwin_arm64.tar.gz"
      sha256 "99a83406591c01ae5164fa0eaaaa35a5c6f6d0a4388c86c6c887d0b4dce96ae9"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippo_v0.28.4_darwin_amd64.tar.gz"
      sha256 "778818d0b9d3f36be44337d3270a4736faa5a7958cffb63d2717e1e099454f28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippo_v0.28.4_linux_arm64.tar.gz"
      sha256 "7f1b35b9ec0c4039f6b09681e2f0735f1c402c543e49a98cb87cb639f63fdbce"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippo_v0.28.4_linux_amd64.tar.gz"
      sha256 "f366b4357bcaac7b0294dc4f1d7507b06cac61241a1e0c25a9564e638d43e9e6"
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
