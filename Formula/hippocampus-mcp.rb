# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippocampus-mcp_v0.54.0_darwin_arm64.tar.gz"
      sha256 "8b525a6c96ac4791a3bebf5f294dfa9146b24360735426bd5ef10b5be4b385ca"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippocampus-mcp_v0.54.0_darwin_amd64.tar.gz"
      sha256 "332256ae3e2b25f8bd579183538d14d30dbfff508f7c8e1258cf29ff8bdf2e6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippocampus-mcp_v0.54.0_linux_arm64.tar.gz"
      sha256 "37386e6ae083d77415b8d0e19275b5b1cb6c4f82347217cd5ae684af2284820b"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.0/hippocampus-mcp_v0.54.0_linux_amd64.tar.gz"
      sha256 "c5a64db20b044de70d96a38dfd4f16ba10b8082071f52080528bd4a84bc678de"
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
