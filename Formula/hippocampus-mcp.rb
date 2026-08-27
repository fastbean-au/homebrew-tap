# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus-mcp_v0.38.2_darwin_arm64.tar.gz"
      sha256 "f0a9ed4aaaddde538dc3d938f8362df29bdd995dc1c9cb0ea74c039959abeef1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus-mcp_v0.38.2_darwin_amd64.tar.gz"
      sha256 "2d81071dbcc3022a1fedf56484d9ae6ef9951abb2c88fde1b3f4a1d9524a035e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus-mcp_v0.38.2_linux_arm64.tar.gz"
      sha256 "05d232392da07951c25a5a986f0d660e286f2ff3114d876da909e2b71e3a1346"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus-mcp_v0.38.2_linux_amd64.tar.gz"
      sha256 "b9b4544679c6bb4d094a1f959dbed8927788c37cc858f4c7017c2f816342efca"
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
