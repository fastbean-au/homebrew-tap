# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippocampus-mcp_v0.48.0_darwin_arm64.tar.gz"
      sha256 "9db935f944adca585d1909e0cec2f6236b5d69b74ba6e8f15ce1b85a20047e2a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippocampus-mcp_v0.48.0_darwin_amd64.tar.gz"
      sha256 "689dbef53cfa2b9f8dd4c8e4d3570f815cedeb4f919d0c8429bac3b1ac2b50cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippocampus-mcp_v0.48.0_linux_arm64.tar.gz"
      sha256 "15c2ddb802315230085dda366fbc916150c32d123a64c1b0158091dc77228493"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.48.0/hippocampus-mcp_v0.48.0_linux_amd64.tar.gz"
      sha256 "b73c554109807b7a8acbd7365ae21971a4c62830c21e38ad9593f9321bdff00e"
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
