# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippocampus-mcp_v0.44.0_darwin_arm64.tar.gz"
      sha256 "00800d654cb684d0667b4cb3f5bba0c74b0031329bbb6374ffe28ee819563dd7"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippocampus-mcp_v0.44.0_darwin_amd64.tar.gz"
      sha256 "1e5aafb7ae058196a3d2ed422e0a9b8a795d672248d9eb24a788f8d8e81a06ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippocampus-mcp_v0.44.0_linux_arm64.tar.gz"
      sha256 "23499d9c8caae299397eb49fdb97ffb71afb401534d2c37563c004410324d7bc"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.44.0/hippocampus-mcp_v0.44.0_linux_amd64.tar.gz"
      sha256 "36f0fdce7b6b5e2c882838a9b6bd10922277f1eef10915f4f723f8b7bae106df"
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
