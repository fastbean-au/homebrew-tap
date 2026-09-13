# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippocampus-mcp_v0.47.1_darwin_arm64.tar.gz"
      sha256 "c9ad47068269820f03d27a23df2fced3dc88546fb7c88378844c1be84d24ae4c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippocampus-mcp_v0.47.1_darwin_amd64.tar.gz"
      sha256 "eb2ccd3c29037bf9ac10d0b2d579864091378619e172f537ba1899c470c74432"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippocampus-mcp_v0.47.1_linux_arm64.tar.gz"
      sha256 "8b027678bf216626bd12a5f176640c2baa47e36c4fcc06141330f1802e5b54eb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.1/hippocampus-mcp_v0.47.1_linux_amd64.tar.gz"
      sha256 "a620623cbbc52199c15fce57a2cce6027259c2681c4f6a0e3692e776e1ffd3ff"
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
