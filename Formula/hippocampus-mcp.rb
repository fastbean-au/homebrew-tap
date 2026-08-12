# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippocampus-mcp_v0.29.1_darwin_arm64.tar.gz"
      sha256 "27d1a306d4559e971d84fbdcf0c10b25aee2da5c181cba3813501ad8624f1efc"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippocampus-mcp_v0.29.1_darwin_amd64.tar.gz"
      sha256 "2977de5f75ece8ac3ee2b63b35f7ba442e2c8241a720de01654c1d795b98b118"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippocampus-mcp_v0.29.1_linux_arm64.tar.gz"
      sha256 "a4faa7243cc2d72a25f9467473b803b90db68ea36a09f2e773eb5f6c63d81a47"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.1/hippocampus-mcp_v0.29.1_linux_amd64.tar.gz"
      sha256 "0ddf96f784dc7813e6bebf8931609d1337b15c54ae5931545d55a46a4c55dad0"
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
