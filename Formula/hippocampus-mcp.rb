# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippocampus-mcp_v0.32.1_darwin_arm64.tar.gz"
      sha256 "8cf3d7745956156d6d1180c5a83c5d220ad488dac5e2802a2f6976ca6a69b889"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippocampus-mcp_v0.32.1_darwin_amd64.tar.gz"
      sha256 "4067fd2ad987e1f9987a4a72434cdaa881d1f4b2aa3fc0f138a4a36d4f9fa4de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippocampus-mcp_v0.32.1_linux_arm64.tar.gz"
      sha256 "1ef88a8c2d6fd4336c0f2e88de009e28b3425c40abbac899724bbbfdeb15652a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.32.1/hippocampus-mcp_v0.32.1_linux_amd64.tar.gz"
      sha256 "f6562d5ef7d521621a7ab22de57e0f992d9907290a4112279b3e5772c773d916"
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
