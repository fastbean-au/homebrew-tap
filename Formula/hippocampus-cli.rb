# The `hippo` command-line client. A prebuilt-binary formula: it downloads the per-arch release
# tarball published by the hippocampus repo's release workflow. version + sha256 are bumped from
# that release's checksums.txt (by hand or the repo's Homebrew bump job).
class HippocampusCli < Formula
  desc "Stateless command-line client for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippo_v0.55.0_darwin_arm64.tar.gz"
      sha256 "1ec6717a9667d109fc40f11efc45712b542da1660e1fd1d4fb2f91ab34af4b88"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippo_v0.55.0_darwin_amd64.tar.gz"
      sha256 "3692474dbdcbae7fbbe013e47a9efb564eadc7d4e62df7891fea0dc3654c84bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippo_v0.55.0_linux_arm64.tar.gz"
      sha256 "dd44d77e9307e0c3973108a421f1680b72eb118407d6fec7c69fe10d8068e3f7"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippo_v0.55.0_linux_amd64.tar.gz"
      sha256 "5d1a9735db690afa2a4da44344e9d773dd4e082c70efc730f3b2aa53f2d4145d"
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
