# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippocampus-mcp_v0.53.3_darwin_arm64.tar.gz"
      sha256 "fa8740a99e1c75e05dd56cd165bdddce28c029c88767afcf2c4c581a550a1290"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippocampus-mcp_v0.53.3_darwin_amd64.tar.gz"
      sha256 "56e89600c5d67f06b44d0010bde6e1714ad82caf38faee6f1493ce90ec1257a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippocampus-mcp_v0.53.3_linux_arm64.tar.gz"
      sha256 "fbc212ec478e1b33b1362109db9cb8362b4357e07bc5fd1140c2196de9c4ad4c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.3/hippocampus-mcp_v0.53.3_linux_amd64.tar.gz"
      sha256 "1a7fd21bef59225060539ede5a7f82200db4c57d4370c493d330dc1c42a08fe1"
    end
  end

  def install
    bin.install "hippocampus-mcp"
  end

  def caveats
    <<~EOS
      hippocampus-mcp is a stdio/HTTP bridge that dials a running Hippocampus service.
      Point an MCP host at it, e.g.:
        hippocampus-mcp --address localhost:50051
      See https://github.com/fastbean-au/hippocampus/blob/main/docs/mcp.md
    EOS
  end

  test do
    # The bridge prints its version to stderr (stdout carries only the MCP JSON-RPC stream).
    assert_match version.to_s, shell_output("#{bin}/hippocampus-mcp --version 2>&1")
  end
end
