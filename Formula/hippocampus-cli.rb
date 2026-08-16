# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippo_v0.33.2_darwin_arm64.tar.gz"
      sha256 "9d96ff3333cd3c01f21b6fc92f20e484cb59cb129511b409f809105d106b0e21"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippo_v0.33.2_darwin_amd64.tar.gz"
      sha256 "f5b913026bdf0d750ac6d1e8b7793eea8ca33c3d6cca2b41af5cddc6aa54c29b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippo_v0.33.2_linux_arm64.tar.gz"
      sha256 "0ddd63c03d9a958026f9f259b16ed99b99647869855e3b45f424e9878b6d6787"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippo_v0.33.2_linux_amd64.tar.gz"
      sha256 "cc33a83783ebc5fe559e72e9d2c5debcd9ccf6be1d0e6351de3f85aed762df00"
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
