# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippocampus-mcp_v0.52.2_darwin_arm64.tar.gz"
      sha256 "4cbd1194c38098ffa88864258f992e4d74b14c667aac013a4a950d3adbf186e6"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippocampus-mcp_v0.52.2_darwin_amd64.tar.gz"
      sha256 "3e90bb2625d0b164788f9d98cfc633f07fdfd155c70013b73e39bc3b388c17dd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippocampus-mcp_v0.52.2_linux_arm64.tar.gz"
      sha256 "0f7d3e2baadee3223138f4a56428c0d4908a45096c330354c3892b4ddcb6119a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.2/hippocampus-mcp_v0.52.2_linux_amd64.tar.gz"
      sha256 "6af0d3c6f4d2155039d452423c65b19d9c1737bf55e9d458108427bbd3be6c50"
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
