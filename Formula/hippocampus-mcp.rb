# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippocampus-mcp_v0.50.0_darwin_arm64.tar.gz"
      sha256 "e1af6ee130b0e815956746e15ee0ed3598f96154ccfabbb90de46e85edd51ad9"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippocampus-mcp_v0.50.0_darwin_amd64.tar.gz"
      sha256 "f7393deddb9adb753ac4cd53034e5a62ed1b16040464ce872535942154c7059e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippocampus-mcp_v0.50.0_linux_arm64.tar.gz"
      sha256 "06308f0e0486d762cea52911b6e3a434e6560fb2b54eafebab2dc65ac6050620"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.50.0/hippocampus-mcp_v0.50.0_linux_amd64.tar.gz"
      sha256 "50335c86cbe2c0f720e92a4c5e8389a8c15a49ba602179a46df3c5213aae251c"
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
