# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippocampus-mcp_v0.42.0_darwin_arm64.tar.gz"
      sha256 "be21af8c87ade5504496b7d525f96cb5a35c3099c34acca8536f539eeb7de482"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippocampus-mcp_v0.42.0_darwin_amd64.tar.gz"
      sha256 "c534ae1eaaa5ab6d669be7911b274f8ddf78ca95868dab0809dd9f28ff4fdfa9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippocampus-mcp_v0.42.0_linux_arm64.tar.gz"
      sha256 "a8afeeba29ea6c5f71d9853797d241837ab975943a67043724001eabedfd061d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.42.0/hippocampus-mcp_v0.42.0_linux_amd64.tar.gz"
      sha256 "c9529648fafde41e32023beb739291d6ea655c6512887b5974143fe0c9b98891"
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
