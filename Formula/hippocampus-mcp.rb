# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippocampus-mcp_v0.21.0_darwin_arm64.tar.gz"
      sha256 "03fd551cd1e85b1755959b2acc9e5a9a464663530f9b29ce684fa9dbcd42267f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippocampus-mcp_v0.21.0_darwin_amd64.tar.gz"
      sha256 "5d06425c59b8cc5a22e2a23ad42ee8c1e14ec124e0e2c13d02496136dd2fa5fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippocampus-mcp_v0.21.0_linux_arm64.tar.gz"
      sha256 "fa7c7b65416f7de0dddc1f27ad9efd350d6846e28af48ef464969a690d3a23ed"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.21.0/hippocampus-mcp_v0.21.0_linux_amd64.tar.gz"
      sha256 "90b0547c67885c9f46565656afc49c12af3fe338f3b1d6992139ac5bba26c85c"
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
