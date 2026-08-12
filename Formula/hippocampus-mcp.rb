# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippocampus-mcp_v0.28.2_darwin_arm64.tar.gz"
      sha256 "5f01dfa9d0038b093371efd7cb2b38c5dfddc656286b0e241983031399027c95"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippocampus-mcp_v0.28.2_darwin_amd64.tar.gz"
      sha256 "ea0c142b639092acc25d89e69a96b27db70d9c2a09856c7c33ad1f4ec57cda07"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippocampus-mcp_v0.28.2_linux_arm64.tar.gz"
      sha256 "b4d51f00a5055146a412e1733c6188fd9e915a6ecd55fa197120f1571948c228"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.2/hippocampus-mcp_v0.28.2_linux_amd64.tar.gz"
      sha256 "e62cefd14fd78b7b90695362f94eba9c05b97b85026d561fab683ebe0e3db3b7"
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
