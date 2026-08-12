# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippocampus-mcp_v0.28.3_darwin_arm64.tar.gz"
      sha256 "42ed346cf440108eb07dbce83529742d0f0eb1fb6634faad6661f578135766f9"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippocampus-mcp_v0.28.3_darwin_amd64.tar.gz"
      sha256 "6bf87de598c835e709ccb73d47ac43c06a0f42fff57fd03f7d5aebd5c9640e2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippocampus-mcp_v0.28.3_linux_arm64.tar.gz"
      sha256 "8c083015f5750420630377eb53d3fb0997511eea163875c013fad18bc4785403"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.3/hippocampus-mcp_v0.28.3_linux_amd64.tar.gz"
      sha256 "0c189d8b9f23cef62320f140331fa18913d2ffbc1d360c93aeed83fceb9fb320"
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
