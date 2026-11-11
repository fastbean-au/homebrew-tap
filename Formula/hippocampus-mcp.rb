# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippocampus-mcp_v0.53.1_darwin_arm64.tar.gz"
      sha256 "3d0c2e81d6ac4a7399d110bb580e745851ed6043579d37c3c4b72abb879aca25"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippocampus-mcp_v0.53.1_darwin_amd64.tar.gz"
      sha256 "37fe76c86c5252dd29dc5b670f6d40baf7a3e4d6cc9f69669f8c5f768ea271a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippocampus-mcp_v0.53.1_linux_arm64.tar.gz"
      sha256 "7dfa1306ed3706c368132b0fd12b98ab178c2849b4f0787cfb408e523a17ac8e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.1/hippocampus-mcp_v0.53.1_linux_amd64.tar.gz"
      sha256 "83d25f7e769c666fb92b866ed0ba9b8daabfdd2e26caca28573e5ec30e374e38"
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
