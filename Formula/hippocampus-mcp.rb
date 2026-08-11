# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippocampus-mcp_v0.28.0_darwin_arm64.tar.gz"
      sha256 "18d7e7d25e594a2732d804b3a630ea91d2cc2283929ca2ac1b95e30c0a9bcfc3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippocampus-mcp_v0.28.0_darwin_amd64.tar.gz"
      sha256 "5eb266b83a9c58c5fc23bd8f185e537eb11aaac041582563cd54992d127b1b48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippocampus-mcp_v0.28.0_linux_arm64.tar.gz"
      sha256 "9930ee3d68ab569e37ec463b3c3c356c902f4a1f478db73ad7261f6d6965b9a7"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.0/hippocampus-mcp_v0.28.0_linux_amd64.tar.gz"
      sha256 "55a2cda7093ac63432a551e200a7574f035592d57bbf7067e0e1a63fd53e11ba"
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
