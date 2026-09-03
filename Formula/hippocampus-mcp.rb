# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippocampus-mcp_v0.40.1_darwin_arm64.tar.gz"
      sha256 "c71986af3e81b6b6f6d04f5700b29c593ca716bcecd3dd915bd7c7a083a4d3b0"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippocampus-mcp_v0.40.1_darwin_amd64.tar.gz"
      sha256 "bce90c2f29901db4c6fc252fd5a19a34ce6439c9f0d5405f444750b1225165e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippocampus-mcp_v0.40.1_linux_arm64.tar.gz"
      sha256 "c07447eceb82aa7a74972c1014f65e9fd13753cc2430916d164900515d6675fe"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.40.1/hippocampus-mcp_v0.40.1_linux_amd64.tar.gz"
      sha256 "f6a972fde0c5130526ccbca267b9e4fdb4f5930d688ff5d58fa3b873af19dbec"
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
