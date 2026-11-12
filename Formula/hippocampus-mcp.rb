# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippocampus-mcp_v0.53.2_darwin_arm64.tar.gz"
      sha256 "14e64d31d4a49b7d516f8321cadc3ba72dc154522f63871ba0a5acc60163df7e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippocampus-mcp_v0.53.2_darwin_amd64.tar.gz"
      sha256 "e59a36eefc124cd9a795430205716618da822307efa8a00cdd3f308a4f993557"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippocampus-mcp_v0.53.2_linux_arm64.tar.gz"
      sha256 "bce54cac50effe0806efaa12430039f16ef4fac4b35a632a29378b65dccb6492"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.2/hippocampus-mcp_v0.53.2_linux_amd64.tar.gz"
      sha256 "ed36a045b4a619a8a386dcab948e458b1beb1930a4fae445d2bce4f9abebcd7d"
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
