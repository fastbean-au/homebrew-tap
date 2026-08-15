# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippocampus-mcp_v0.32.2_darwin_arm64.tar.gz"
      sha256 "765c6f4151fff477a291a69ee26ae56748b228c4a2ff680436d45c89d35ad111"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippocampus-mcp_v0.32.2_darwin_amd64.tar.gz"
      sha256 "1ab518dc9f88ef9ac3f182ff6e86b80f091de34f93936d03f8b2eb96907d6791"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippocampus-mcp_v0.32.2_linux_arm64.tar.gz"
      sha256 "e1a6f86ccf6712f5b446196dc9f9d5c60c591c20dcc477a1b134ae47531e819f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.2/hippocampus-mcp_v0.32.2_linux_amd64.tar.gz"
      sha256 "f5ce06ecb5e6ba68b172a0dcaf191c45b99061491c03230a43ee61308389597c"
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
