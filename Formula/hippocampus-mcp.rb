# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippocampus-mcp_v0.46.0_darwin_arm64.tar.gz"
      sha256 "62ed707e73f5f33f58dd43d009feed995f55ee6211c979265023ad9b34147525"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippocampus-mcp_v0.46.0_darwin_amd64.tar.gz"
      sha256 "a092b889e272f0c16db1fa0c5eafbbf919621eb6b9f9a73e08688f29d908a39c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippocampus-mcp_v0.46.0_linux_arm64.tar.gz"
      sha256 "e0772d641a25d301dc020bbd283f74a5fb8ad1437473863fa654f246dfb43705"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.46.0/hippocampus-mcp_v0.46.0_linux_amd64.tar.gz"
      sha256 "359750e1480d0ebe70a39c7cf1d52dedcfcaff2bcfb5d21dc5f210ccc60a9abf"
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
