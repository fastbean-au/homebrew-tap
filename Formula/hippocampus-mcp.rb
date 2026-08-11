# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippocampus-mcp_v0.27.0_darwin_arm64.tar.gz"
      sha256 "23e788c353c06a314bbfdfde493ecfee69b95109b471b2834c9a55711a8c6b08"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippocampus-mcp_v0.27.0_darwin_amd64.tar.gz"
      sha256 "3e909a441705c9ce8a4914843995f530151bca8f6b3c4f670cff4ca7e05de938"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippocampus-mcp_v0.27.0_linux_arm64.tar.gz"
      sha256 "00fe302ce2bac642a75ebc66672e2552fedd47b7af99e72a4171ee9ebfbb3b48"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.27.0/hippocampus-mcp_v0.27.0_linux_amd64.tar.gz"
      sha256 "a4a131bb1052aefd57e966c8c4d4fa491fd83a86c1b29b3270f8201f097c3ce4"
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
