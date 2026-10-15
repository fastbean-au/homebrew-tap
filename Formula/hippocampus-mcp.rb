# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippocampus-mcp_v0.52.3_darwin_arm64.tar.gz"
      sha256 "c4754f27d4f16cb8f956b2431651dd1946f71eca88877dc589328b9548bed7fb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippocampus-mcp_v0.52.3_darwin_amd64.tar.gz"
      sha256 "66de8529db8644b4eed2aee62dfeae96ba4e42b285060232c6b63c76559bf376"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippocampus-mcp_v0.52.3_linux_arm64.tar.gz"
      sha256 "0928296878f8c244dfa73bb7e5381e8249b6b4d6c64f94991e80ef8ae798d941"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.3/hippocampus-mcp_v0.52.3_linux_amd64.tar.gz"
      sha256 "266b6332ee38ece91a19f3dfbe8340ea795c5291b259131336f62b64ed8da08c"
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
