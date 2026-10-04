# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippocampus-mcp_v0.51.1_darwin_arm64.tar.gz"
      sha256 "2ec7da9277ac1ef65f0a9e3821506311f06566a1a7d3f3d0813ba413f453f2c2"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippocampus-mcp_v0.51.1_darwin_amd64.tar.gz"
      sha256 "3bf41e153f6f843d30e8708404aec19e01fbbec39e8132a4d78195936d48d930"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippocampus-mcp_v0.51.1_linux_arm64.tar.gz"
      sha256 "e0aada033010dc18a411147292ff294e5b407865c9a78d51e8994cc2173c4324"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.1/hippocampus-mcp_v0.51.1_linux_amd64.tar.gz"
      sha256 "f6d465262416d5bd8db673739bcba8664691b17bad25fb499cc564692d81fa09"
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
