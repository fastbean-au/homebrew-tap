# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippo_v0.36.1_darwin_arm64.tar.gz"
      sha256 "6dd3b1182aa0d39ba4440ca5ed0926724f74b5ccaf78c9de31403863b34bb7e6"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippo_v0.36.1_darwin_amd64.tar.gz"
      sha256 "4cb25dc0270b21ca669d8b567b26051c1287c358f8772de779c0e4a9ca43a28f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippo_v0.36.1_linux_arm64.tar.gz"
      sha256 "db7838d5b7acca2c65b248c6c577141c0da93ef4a3d4b10a5f4ff163f086dbac"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippo_v0.36.1_linux_amd64.tar.gz"
      sha256 "fcc66116058e880034abc24143123e1ffa5b6cf0e56300563d9ce45816be1b7a"
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
