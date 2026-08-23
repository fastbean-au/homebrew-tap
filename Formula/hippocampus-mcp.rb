# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus-mcp_v0.37.0_darwin_arm64.tar.gz"
      sha256 "368d6088075cad3985a2e1eaabf9304a181b6d29ee7210dd5e9f050bbf528f60"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus-mcp_v0.37.0_darwin_amd64.tar.gz"
      sha256 "991d522c121a055191ae7e5a1a6423dd2818b2f6602a7d7c0355264c99d5bf48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus-mcp_v0.37.0_linux_arm64.tar.gz"
      sha256 "0442ebb43a44e2b9ccc79d1ea79c9101540cd81f400b680455b617c7e6a384a5"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus-mcp_v0.37.0_linux_amd64.tar.gz"
      sha256 "843f029f21a1f5e69677ee23b871c625664944a3c3ca0d3d2f84dde7396007a1"
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
