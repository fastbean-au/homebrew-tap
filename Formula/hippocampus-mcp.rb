# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippocampus-mcp_v0.41.0_darwin_arm64.tar.gz"
      sha256 "0cf902498d7f08d0042d0792b751efdee9843a4ff05efe40cdd85918b91fa58c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippocampus-mcp_v0.41.0_darwin_amd64.tar.gz"
      sha256 "53f13ec8914832fca0272bbbf2a24b388e8b5c90a03cc232f9e79c482517f9d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippocampus-mcp_v0.41.0_linux_arm64.tar.gz"
      sha256 "9a0b69cf74ae9a88ea7a48aeec9684131690c030dae4883fabcaa53082f72523"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.41.0/hippocampus-mcp_v0.41.0_linux_amd64.tar.gz"
      sha256 "d919aef9f6910f839c29ab43abd3d72d8d0ea4b4a28293cebf1d1a32496abbac"
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
