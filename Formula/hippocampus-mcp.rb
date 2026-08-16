# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippocampus-mcp_v0.33.2_darwin_arm64.tar.gz"
      sha256 "db03fb87648fcd958511e12bccc41bd9c359407a4427b3b69c969e2a206abe58"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippocampus-mcp_v0.33.2_darwin_amd64.tar.gz"
      sha256 "ee469da6151149b6460d2ecd7da1481816c32e5f084c33d9d6d388ac81301530"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippocampus-mcp_v0.33.2_linux_arm64.tar.gz"
      sha256 "de32c9a95bb6776a4209376498c68dd05bedddb9d3056364890815857692eeb4"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.33.2/hippocampus-mcp_v0.33.2_linux_amd64.tar.gz"
      sha256 "b6e78563bdb86fce83127614f93ce7f3213955ca266f5c247505a60e4e91e9a3"
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
