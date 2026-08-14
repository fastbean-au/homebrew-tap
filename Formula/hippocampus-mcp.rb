# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippocampus-mcp_v0.31.0_darwin_arm64.tar.gz"
      sha256 "687bfd4babd0b19a1025fb280773c646102a2800db2bfbab7204e1cc265e12af"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippocampus-mcp_v0.31.0_darwin_amd64.tar.gz"
      sha256 "f1d3dd772dcf48c4c88388e2a6a9211c3dcae6aec135623eb55135a2a6373c9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippocampus-mcp_v0.31.0_linux_arm64.tar.gz"
      sha256 "3c1e09de3b2ab6f0e9cf0d637b8b8eb70608f48b646f31e33b1ad293560c44b3"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.31.0/hippocampus-mcp_v0.31.0_linux_amd64.tar.gz"
      sha256 "3504544c68e217e0a90bb474afdbad945176fa8934aa414a819da1aaef4d9d8e"
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
