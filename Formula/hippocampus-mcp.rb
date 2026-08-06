# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippocampus-mcp_v0.24.0_darwin_arm64.tar.gz"
      sha256 "cf864c3b00c17c9ce9d6f40ec5e67318bfec4bc6f8f9713094e4f4bf80b01a62"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippocampus-mcp_v0.24.0_darwin_amd64.tar.gz"
      sha256 "52b97679aaa116eb491eb9d64df14f84c0fb3da8e813132082d837b20ba87c09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippocampus-mcp_v0.24.0_linux_arm64.tar.gz"
      sha256 "a286fb0adf20d4d6bb3cb0393db92fc9da642cdd9e6349d4a7867b733b677111"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.24.0/hippocampus-mcp_v0.24.0_linux_amd64.tar.gz"
      sha256 "eb7ab8e9abfb53aaf60c8d8b455d31f2e4721e39f2cac62127f11fbf6c4e9d7b"
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
