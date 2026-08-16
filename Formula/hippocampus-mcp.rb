# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippocampus-mcp_v0.33.1_darwin_arm64.tar.gz"
      sha256 "646e0afea2bc95bab560f516b4c163f3acbcdbd75d0bcf0caf6a2fc2fe516d4f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippocampus-mcp_v0.33.1_darwin_amd64.tar.gz"
      sha256 "9a720f08071e00b52e70f8ee6da705b19aad742337862ccd30108bfd7b522adf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippocampus-mcp_v0.33.1_linux_arm64.tar.gz"
      sha256 "5afe7f291c10aecaa2d8bd2b6462397c401420e2e285d6524a6384394d02b8dc"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.1/hippocampus-mcp_v0.33.1_linux_amd64.tar.gz"
      sha256 "9497904fe3285701d1f2ba3e7c89c6cc3edbf3b9e331a9b6744c92c01e559736"
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
