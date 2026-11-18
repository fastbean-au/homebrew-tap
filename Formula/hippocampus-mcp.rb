# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus-mcp_v0.55.0_darwin_arm64.tar.gz"
      sha256 "d0a3d6f5b93686c3dfb8cc271adc001b8767e1abf817f0f2f803fc5c623ca0a0"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus-mcp_v0.55.0_darwin_amd64.tar.gz"
      sha256 "7ab2053aa4e83d873941eeca6bd1e744ec3347925c4ac260b96f0218e61006bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus-mcp_v0.55.0_linux_arm64.tar.gz"
      sha256 "15e101e60c4bed2b15959c4d1f8f924cb1d9276a2715c5b907c1dd9427c31b0d"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus-mcp_v0.55.0_linux_amd64.tar.gz"
      sha256 "ac77aa5c547e863f13c71417278531ede52f1628b766a3719972127f6b512472"
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
