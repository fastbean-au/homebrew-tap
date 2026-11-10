# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippocampus-mcp_v0.52.7_darwin_arm64.tar.gz"
      sha256 "9c43abdac7fb6aa7c13812fd7208c1d00fc626d5792f91362bd94c721e2cab1d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippocampus-mcp_v0.52.7_darwin_amd64.tar.gz"
      sha256 "ad863000497c7fd8233e6eb39ac2ccb6955de2091b3b8823e2fc43f3a9bb0b56"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippocampus-mcp_v0.52.7_linux_arm64.tar.gz"
      sha256 "52bf34d0ac1d3bb12a0c9b94d2e12af6c0893f02c2d48c988a411779f3a0d4c4"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.7/hippocampus-mcp_v0.52.7_linux_amd64.tar.gz"
      sha256 "3ddb626c0e38609f54f9abfad868a361176e2bef96fdd3aaa9ddab42e4ab94f3"
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
