# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippocampus-mcp_v0.38.3_darwin_arm64.tar.gz"
      sha256 "10785f4adfaa5ef3b3f5de14ac33274fe9e8bcc7f521074f85fd04ad5a0fc6cc"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippocampus-mcp_v0.38.3_darwin_amd64.tar.gz"
      sha256 "ad2284ac2bccce8fe8286b06a95bbb8c22305d4cd7f07fbe44c707bbe5183362"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippocampus-mcp_v0.38.3_linux_arm64.tar.gz"
      sha256 "4c4d986830889a289416b6fbfde154014a9ebf187066ba2c835f979fc4f72e78"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.3/hippocampus-mcp_v0.38.3_linux_amd64.tar.gz"
      sha256 "a0123ae330cbd5160cbf3d6a86519ccf0c03a6d3b3be1fd07c00b1290bf14668"
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
