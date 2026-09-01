# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippocampus-mcp_v0.39.0_darwin_arm64.tar.gz"
      sha256 "d170a6f60b9b504c7f0a58f355d00fbff9239178d83fe4e346e37810abe89406"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippocampus-mcp_v0.39.0_darwin_amd64.tar.gz"
      sha256 "7072f9ad3a321923415255008f701962564fd166cf077f515640e5a35dd480c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippocampus-mcp_v0.39.0_linux_arm64.tar.gz"
      sha256 "cbd0f5134769eff194720e8e0688a76de0e5ce343afbdacced22c67da667bc3b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.39.0/hippocampus-mcp_v0.39.0_linux_amd64.tar.gz"
      sha256 "f37b0096d89b68ac281271d123b2d103c04211be17178945136116fab51c95c7"
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
