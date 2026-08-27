# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippocampus-mcp_v0.38.1_darwin_arm64.tar.gz"
      sha256 "25b2b4f1bc0747e3ff08e1a86e08fd7d2a2c85b201ed993e4af2452950652d1a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippocampus-mcp_v0.38.1_darwin_amd64.tar.gz"
      sha256 "f673d25451831e199b05185ea9c37c2bc6e7eb50d565565188bec30dbd6a41c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippocampus-mcp_v0.38.1_linux_arm64.tar.gz"
      sha256 "5e60b457128962e3eea0ed418f7a9c0e3d9496364e40d8f7fac80b4db1bd0b7f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.1/hippocampus-mcp_v0.38.1_linux_amd64.tar.gz"
      sha256 "b0a3f4ab925f0513411155aa973b55458570baecf8811536df59b1b1288473f7"
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
