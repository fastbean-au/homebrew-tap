# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippocampus-mcp_v0.38.0_darwin_arm64.tar.gz"
      sha256 "195a40673ca53386377c3e0d8662064ee42fabc2c18b112ec946b3c32b298e66"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippocampus-mcp_v0.38.0_darwin_amd64.tar.gz"
      sha256 "06effe2f10cd3081bede5a6fee35aaf28d8f356203f35f54fd98b98922ba8845"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippocampus-mcp_v0.38.0_linux_arm64.tar.gz"
      sha256 "0e4950392474c928bc014a505c1231665afee28822208a29545c45355216a4d4"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.0/hippocampus-mcp_v0.38.0_linux_amd64.tar.gz"
      sha256 "d4d542677b3cefa251d06f4d186c53b5aed19a46f2c8c2adc71cbbf1740e37f7"
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
