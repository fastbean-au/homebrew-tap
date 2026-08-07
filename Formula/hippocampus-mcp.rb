# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippocampus-mcp_v0.25.0_darwin_arm64.tar.gz"
      sha256 "60566113e4e9717c8da154f76479f1418536152101ef4bd091f7bb33df3bee0f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippocampus-mcp_v0.25.0_darwin_amd64.tar.gz"
      sha256 "4d84618917ebf9ed54cced2635c0fe0b8fa185afcb9292b7a1ee95a8e60c06fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippocampus-mcp_v0.25.0_linux_arm64.tar.gz"
      sha256 "a187b507e40c029c19faad652722d8e1a884206c0d9f154e76b4110fd626abaa"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.25.0/hippocampus-mcp_v0.25.0_linux_amd64.tar.gz"
      sha256 "10011db451739dfdf61ec37fc2b4b754fbea016604e896fd5eab712cbf3eb0bc"
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
