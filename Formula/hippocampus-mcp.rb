# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippocampus-mcp_v0.36.1_darwin_arm64.tar.gz"
      sha256 "c2e65fad6b098ebfb498f7d64918329a0e641cfe9658b9191ae7f4047d2bb359"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippocampus-mcp_v0.36.1_darwin_amd64.tar.gz"
      sha256 "1acd3b902d7dc1ad4279eb0cba23d8832d3f37159ada004b6164a6564b35f6d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippocampus-mcp_v0.36.1_linux_arm64.tar.gz"
      sha256 "fc9eb6c776d32e0bca52964c217777fe0e2ecaf9f86169a0f15ea96fee56a30c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.1/hippocampus-mcp_v0.36.1_linux_amd64.tar.gz"
      sha256 "3e409d742a1c05241279f391ef1eeb05d9391352f66c2d7de3699e65ca0f2564"
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
