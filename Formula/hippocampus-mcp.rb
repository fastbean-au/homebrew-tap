# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippocampus-mcp_v0.52.4_darwin_arm64.tar.gz"
      sha256 "5be965cd6f17ef6802802ed77ef314a09e40277aad85938ed6fe06440a329b4c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippocampus-mcp_v0.52.4_darwin_amd64.tar.gz"
      sha256 "cee94a25051a7df90d966f147aa55fcd63b6a76d52b5f49039beab5b39d2a7a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippocampus-mcp_v0.52.4_linux_arm64.tar.gz"
      sha256 "a1ec304650201a2aa8ff147e353888794f71459f5d7b849fea6314738ecbb5e4"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.52.4/hippocampus-mcp_v0.52.4_linux_amd64.tar.gz"
      sha256 "4b09c4c091f6e9867579cdfb3b4af1b29a2be25e8a9a8b69982a3cebe948cf8b"
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
