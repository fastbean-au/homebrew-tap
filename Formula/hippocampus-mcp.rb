# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippocampus-mcp_v0.29.0_darwin_arm64.tar.gz"
      sha256 "0ac92329f3e3d86eb29afe0a59c049560b863ea06b58324a27ee51f547c79a92"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippocampus-mcp_v0.29.0_darwin_amd64.tar.gz"
      sha256 "45e2281bd709fe2739d963d31d7681b87c90576cbd30e4cdf8a0de75805da772"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippocampus-mcp_v0.29.0_linux_arm64.tar.gz"
      sha256 "e1b5f02122a7df684a32a17bb1084d5d061363ec5ec96339b0cac66159b9c89d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.0/hippocampus-mcp_v0.29.0_linux_amd64.tar.gz"
      sha256 "2e26d601ab812d4b94d6d18941edd9bddb1e3ad71d674a3aa72f8d947f6cc7b7"
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
