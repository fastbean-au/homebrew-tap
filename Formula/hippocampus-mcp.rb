# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippocampus-mcp_v0.52.1_darwin_arm64.tar.gz"
      sha256 "32f7fffff324dd0aa5ab5dfa4ee23528d1d5fc4cc4f91403a085f70e7a8bf01d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippocampus-mcp_v0.52.1_darwin_amd64.tar.gz"
      sha256 "462d3accdac3076bb3abb945b26422aa4deb8aba305e77d51f91460c0ca3f210"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippocampus-mcp_v0.52.1_linux_arm64.tar.gz"
      sha256 "2adba6bdc468376bff2ad6ea59b3f5dd75dce7bf265cfb4b7f03b52368b44e06"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.1/hippocampus-mcp_v0.52.1_linux_amd64.tar.gz"
      sha256 "cb212ee0c4cefb27f0a18df8f1c6b436941c866166669367dfcdb68ec7e957c8"
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
