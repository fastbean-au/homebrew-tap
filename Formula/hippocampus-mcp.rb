# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippocampus-mcp_v0.28.1_darwin_arm64.tar.gz"
      sha256 "6bc15610c25ffa89c34f80b6d7b8bc015facd9e1d57587c1cb15a4ddfc2cafbb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippocampus-mcp_v0.28.1_darwin_amd64.tar.gz"
      sha256 "ef15450b3cf75fbc548033933677476e81350a38b5aa5788ee8038f803752f25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippocampus-mcp_v0.28.1_linux_arm64.tar.gz"
      sha256 "02eec3f6b825063585e19dadec03b55b95b9bcf1250dda2b922119aec3c90c1b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.1/hippocampus-mcp_v0.28.1_linux_amd64.tar.gz"
      sha256 "54c7725a41043c8f3b563d3a833fe5de34ac14e4511bf2af6850a29ce333733b"
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
