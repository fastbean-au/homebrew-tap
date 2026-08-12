# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippocampus-mcp_v0.28.4_darwin_arm64.tar.gz"
      sha256 "4443af35372f30ee7e741294fa546d58196c1230e5fabf54d864a3fe39250444"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippocampus-mcp_v0.28.4_darwin_amd64.tar.gz"
      sha256 "05482ccd28ffbbe7ba874c7da76ded98ce41a9756021df8e372340899c98f591"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippocampus-mcp_v0.28.4_linux_arm64.tar.gz"
      sha256 "45680ead59b93bce7e1ca908e985be9cf157f417e95216ab7c5fae7cfa1def0f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.28.4/hippocampus-mcp_v0.28.4_linux_amd64.tar.gz"
      sha256 "a1bcd6b8619ea3384d7065c56c72e2720feac8baeafa57578ae1211bd2cb7ec3"
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
