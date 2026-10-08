# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippocampus-mcp_v0.52.0_darwin_arm64.tar.gz"
      sha256 "2291b12054a4fb93fa2cba6f3acc2ba8f1ab84f971e4cd6d3730913da3ff62bb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippocampus-mcp_v0.52.0_darwin_amd64.tar.gz"
      sha256 "a86d36784626d61b669ca57a2b2bfa1f7a6799fe6a5cdc4b5a2efd9af5dbc495"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippocampus-mcp_v0.52.0_linux_arm64.tar.gz"
      sha256 "375501dbccbed790f8496cdd5d7adc16831ed12b67128fa9c6638785aa3291c5"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.0/hippocampus-mcp_v0.52.0_linux_amd64.tar.gz"
      sha256 "5a3018902a4da134e175d91c4254959aa1acac3c6f90da6370436c1d34370798"
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
