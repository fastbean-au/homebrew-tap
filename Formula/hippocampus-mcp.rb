# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippocampus-mcp_v0.26.0_darwin_arm64.tar.gz"
      sha256 "e4003965df931c297334fe9d9a6983054a2cc6001a9113001c211babce8d2f0b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippocampus-mcp_v0.26.0_darwin_amd64.tar.gz"
      sha256 "a409a3c552fce64d0dbefb6aeaa9be9395231ea8470630986daab2b5b33acfeb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippocampus-mcp_v0.26.0_linux_arm64.tar.gz"
      sha256 "87f84b731ed49902a816cc9e8f52eaede0b60ff05b2861a0c2cd7becf9e7f838"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.26.0/hippocampus-mcp_v0.26.0_linux_amd64.tar.gz"
      sha256 "10a3ac36f216ac973cc46bcdea0077d7c12beaf928b24161bdc4ef497e49d04c"
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
