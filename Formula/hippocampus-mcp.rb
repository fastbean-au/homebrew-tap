# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippocampus-mcp_v0.34.0_darwin_arm64.tar.gz"
      sha256 "ad1278d1b5185ba4bfb56212152701b1775298a983ec57f28b84816c98f978d6"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippocampus-mcp_v0.34.0_darwin_amd64.tar.gz"
      sha256 "6f198ca0e87f77143247575aadd9a092e287e9cc79646b77f8405dd6a0c16d06"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippocampus-mcp_v0.34.0_linux_arm64.tar.gz"
      sha256 "830eff5ab726db87e6b42c6ad8efc5e102374301889178b7933a35eaf9022b38"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.34.0/hippocampus-mcp_v0.34.0_linux_amd64.tar.gz"
      sha256 "dccf90a0bd1edfcce59f669bdfcc3edc5ba085c9da0dcf946aa3087ce67f73ec"
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
