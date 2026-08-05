# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippocampus-mcp_v0.23.0_darwin_arm64.tar.gz"
      sha256 "307a7c7ca4c1692cf40452564ce06affc1b979d2ba107e65924208db815a18af"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippocampus-mcp_v0.23.0_darwin_amd64.tar.gz"
      sha256 "ce3788cee50bdcaa3415867bf60f68602077a7fa0e8310d740c5f17303fce8a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippocampus-mcp_v0.23.0_linux_arm64.tar.gz"
      sha256 "5cdb9743643dbc4fc6eb0c9d201ac5734be23fc268172155ead2cccba9f50a45"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.23.0/hippocampus-mcp_v0.23.0_linux_amd64.tar.gz"
      sha256 "742c30bf2db2f929afd91e03518387ab821d701a97e715e0a62bfe56a1e366f3"
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
