# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippocampus-mcp_v0.40.0_darwin_arm64.tar.gz"
      sha256 "0dd0b006b62df9ff54874ec378ad1ac5901ada9b0159da7ee2d69a691dd22de3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippocampus-mcp_v0.40.0_darwin_amd64.tar.gz"
      sha256 "86e8296f79d4b41be228c5ab8bbbe7fa6028562cb0ba3653f9ba8c474a1c5f42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippocampus-mcp_v0.40.0_linux_arm64.tar.gz"
      sha256 "e12671cc018a9a07efd66f14934955cbbce964112e209833324372d49e4ae7e7"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.0/hippocampus-mcp_v0.40.0_linux_amd64.tar.gz"
      sha256 "d7c687ece637622b8eaef0708efffed55db5364e3c5bc93985a0aa72323af7a7"
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
