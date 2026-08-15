# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippocampus-mcp_v0.33.0_darwin_arm64.tar.gz"
      sha256 "0da36dde4b81988939012f14f63f69bab46ec0d1933a73a6a372f8bf23227276"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippocampus-mcp_v0.33.0_darwin_amd64.tar.gz"
      sha256 "1c4523448efa4321702aa91b31f0a0e7ba5e843bd33c49e51ad9f938d4f931e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippocampus-mcp_v0.33.0_linux_arm64.tar.gz"
      sha256 "5139f7bf62ca3da0b50ff986d22edbbe16eb158a48a79773dd811affe0269755"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.0/hippocampus-mcp_v0.33.0_linux_amd64.tar.gz"
      sha256 "9239a05f5b4e2f2a36c8ab0b1fb0facc7ed42f2d910f798da70164c5964b690f"
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
