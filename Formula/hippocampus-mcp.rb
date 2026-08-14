# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippocampus-mcp_v0.32.0_darwin_arm64.tar.gz"
      sha256 "994ad49fa976c5eb61db34bcc8608b75e7a23a5572a0c2f1be3fb6475c9183bf"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippocampus-mcp_v0.32.0_darwin_amd64.tar.gz"
      sha256 "2eb19651320eb519b44ef27c9fdc2f0a8d80754e9d200ba73c09af9eaf87c19b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippocampus-mcp_v0.32.0_linux_arm64.tar.gz"
      sha256 "c10b1cb86281f494f8d90d5d12b922a7c95fa86e32bbeb35b8d86a728b072d56"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.0/hippocampus-mcp_v0.32.0_linux_amd64.tar.gz"
      sha256 "723fa7de47def6eaae98b1638f1bef0792222aacc6aaa1d1e4a4ed48d92c98f0"
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
