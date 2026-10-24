# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippocampus-mcp_v0.52.5_darwin_arm64.tar.gz"
      sha256 "38eba157da5a8663c543995337790244f74b56e393e3465b87b2f46f0d23ecd1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippocampus-mcp_v0.52.5_darwin_amd64.tar.gz"
      sha256 "8111ffe243ec56cfd4ade1c833fd8c4fdbdeba8d3c02dc57a29b26d01f6ca849"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippocampus-mcp_v0.52.5_linux_arm64.tar.gz"
      sha256 "bf74a756a82fe227c6db3cec19fe7cffac464fcd3e1fa4af94bde7bfcdc75a72"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.5/hippocampus-mcp_v0.52.5_linux_amd64.tar.gz"
      sha256 "c9dd3f5f89540d8fb55d60f01e53fbc136caa81cd166f1a46e230ec935e5e7bc"
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
