# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippocampus-mcp_v0.30.0_darwin_arm64.tar.gz"
      sha256 "78ce9ea3a706093598f6a13b523096d54316738fa56349d3cf62b997a2be6bc6"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippocampus-mcp_v0.30.0_darwin_amd64.tar.gz"
      sha256 "519378f48b4e044510452b1c4e8516933a43845f7f70372b55b561c8fabe72ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippocampus-mcp_v0.30.0_linux_arm64.tar.gz"
      sha256 "ba30a95b614cd67e607308eb4f54d12a3ca8db6854510907f1abbe7deb019e86"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.30.0/hippocampus-mcp_v0.30.0_linux_amd64.tar.gz"
      sha256 "fd7dc23dd9b6aef1ccc81cc482b33608f76c5c5a8ab3f989a2e774b32d8a08da"
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
