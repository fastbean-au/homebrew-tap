# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippocampus-mcp_v0.22.0_darwin_arm64.tar.gz"
      sha256 "477d648037ab6123540381e6d53291301832b64fec8c3e9d502b563d91489037"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippocampus-mcp_v0.22.0_darwin_amd64.tar.gz"
      sha256 "ad460ffaf9528e7f24087c72c2b01ceb85bb59abe58cd79847ee287f0701f4e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippocampus-mcp_v0.22.0_linux_arm64.tar.gz"
      sha256 "1ba7107e54315391b5fbcbcdfd8579b22f4b358a5fbcf4adbec4e0aa4f6cde26"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.22.0/hippocampus-mcp_v0.22.0_linux_amd64.tar.gz"
      sha256 "bae958f91755229483bac32a15de4e5a95c9fc221410bd50bae9cd6dbe4efbc4"
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
