# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippocampus-mcp_v0.52.6_darwin_arm64.tar.gz"
      sha256 "8e20dc72af312016c6968c092a6865755e7f7a1273337e5630a8949883457d3f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippocampus-mcp_v0.52.6_darwin_amd64.tar.gz"
      sha256 "1891eed91ad8fd4e77c1f12fa39fb26675d568521d21cc5beb393f135461b960"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippocampus-mcp_v0.52.6_linux_arm64.tar.gz"
      sha256 "85560e1e733ff46bb1a265095d99417341f07b3bccbbd70952a5e1538d7085ff"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.6/hippocampus-mcp_v0.52.6_linux_amd64.tar.gz"
      sha256 "25929d4a573b5a15ef3c8793f17467776860b34a19b76ee44352eb7e80d10a8c"
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
