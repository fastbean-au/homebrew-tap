# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippocampus-mcp_v0.29.2_darwin_arm64.tar.gz"
      sha256 "039deb48f4b9c598e74ff6ca330752b859ae95df473192c03dd3fe6e956b4663"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippocampus-mcp_v0.29.2_darwin_amd64.tar.gz"
      sha256 "6fa387e28fbb5eac2fd0f8d3e8c0f7f5f7f3f96143521f0f63fd5607386889c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippocampus-mcp_v0.29.2_linux_arm64.tar.gz"
      sha256 "c63ae49746206f35db0b692b125509359ce4d51a3bb9b1290da3c7712047ace9"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.29.2/hippocampus-mcp_v0.29.2_linux_amd64.tar.gz"
      sha256 "33772f75819f38c0914def6886355dee8234fb41909fade407ce29f5c040f61a"
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
