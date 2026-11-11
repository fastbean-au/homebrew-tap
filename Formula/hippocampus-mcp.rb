# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippocampus-mcp_v0.53.0_darwin_arm64.tar.gz"
      sha256 "3e0b04014fcb7fa9310736ca15f41b77da901fea66064199c9326f7c83f68a16"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippocampus-mcp_v0.53.0_darwin_amd64.tar.gz"
      sha256 "ccae15a0e80591f348231d29e1e941e7401c98941537fc821f5bd84a68182e12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippocampus-mcp_v0.53.0_linux_arm64.tar.gz"
      sha256 "3e11a7637f67294ccd8987500fb21731f506d777b96dbb540e5a2eb770af0653"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.0/hippocampus-mcp_v0.53.0_linux_amd64.tar.gz"
      sha256 "5d5109345b11577f5dfcc4aafc7274ba2332e6219211710ae8f39061fbd402a2"
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
