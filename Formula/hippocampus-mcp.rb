# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippocampus-mcp_v0.35.0_darwin_arm64.tar.gz"
      sha256 "92588feffdf057912c9cc8cf9dd96c49d01772dcb6a351bd7605f698953ca6ab"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippocampus-mcp_v0.35.0_darwin_amd64.tar.gz"
      sha256 "801e1bf2e7fda5a09d2de5d7af537bba127b4f8db4a36ee9c420212038315a05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippocampus-mcp_v0.35.0_linux_arm64.tar.gz"
      sha256 "5205fd1414d4e14369dd76e1fb31a823442b820f6cbe1a2fe779377bf72204ff"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.0/hippocampus-mcp_v0.35.0_linux_amd64.tar.gz"
      sha256 "9957b11cd85ae69459941870ef764a90ec52124eca5db951f961e4bd052758ab"
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
