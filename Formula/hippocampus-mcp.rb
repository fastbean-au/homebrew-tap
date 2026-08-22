# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippocampus-mcp_v0.36.0_darwin_arm64.tar.gz"
      sha256 "d7cf154e4aa1f94a47d6e634435235e6b1d428fa1d1b3739fad06e3716eff94a"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippocampus-mcp_v0.36.0_darwin_amd64.tar.gz"
      sha256 "1fe38d84504084883fab05ea2ff4a9262172e4d56ebc78f92ff40a78fc40a7bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippocampus-mcp_v0.36.0_linux_arm64.tar.gz"
      sha256 "642782f8abf174386c21f683070ce9d60076bda80ceb4a79b88045c015a0fc77"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.36.0/hippocampus-mcp_v0.36.0_linux_amd64.tar.gz"
      sha256 "caba1d6f1e3a7b5ebe5b6bacaef3e26f143fb7fb0366adef15b6c2fc04be01fe"
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
