# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippocampus-mcp_v0.20.0_darwin_arm64.tar.gz"
      sha256 "1c4917b65093bf687b90b8dd95c16d246dbdff6888d0f2aa35a33008a3a750ec"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippocampus-mcp_v0.20.0_darwin_amd64.tar.gz"
      sha256 "d28a2a0c5ee8859ff92cae0627cdd3e6b51daea7572638d2d08aea3304b7087f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippocampus-mcp_v0.20.0_linux_arm64.tar.gz"
      sha256 "5b6152bd27a612241e9e1482c9942f76d335fef8dcf91e879b92d4d0524cc70a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.20.0/hippocampus-mcp_v0.20.0_linux_amd64.tar.gz"
      sha256 "0b9d049a0ba02074d45e2466d9e95d94ee305f5be697a8ae7ba2e4bd7426e445"
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
