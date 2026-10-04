# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippocampus-mcp_v0.51.0_darwin_arm64.tar.gz"
      sha256 "d234eb85a48c995da069b9ee1d19e26cd0039b8b6b3723694d95b115421961e1"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippocampus-mcp_v0.51.0_darwin_amd64.tar.gz"
      sha256 "e5ef3eac3edada939fb56273ca640e7d16694e1168246f3882608033b15fd8fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippocampus-mcp_v0.51.0_linux_arm64.tar.gz"
      sha256 "e4ee52be7d45d01ca484f682d477335faffcb90cc64c17016cf69c2fbe1334ba"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.51.0/hippocampus-mcp_v0.51.0_linux_amd64.tar.gz"
      sha256 "8873f14891b864a04ecd9e53bc193dfd715c7fbcedc4aabbe7635a5fd31761d8"
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
