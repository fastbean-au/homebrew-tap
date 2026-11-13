# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippocampus-mcp_v0.53.4_darwin_arm64.tar.gz"
      sha256 "c9e13c907f56726dfed4fccf38fa0b053ddf727d7857f51f561a70428455711e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippocampus-mcp_v0.53.4_darwin_amd64.tar.gz"
      sha256 "2c44d6ca1add476e66eb9566c82cdbcaebd9ffaf4863effbff623a448906a7ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippocampus-mcp_v0.53.4_linux_arm64.tar.gz"
      sha256 "81af11a78d775d02f25cd96e657d657c47fb1d7bde8ac3612f5cc41c8c8055d0"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.53.4/hippocampus-mcp_v0.53.4_linux_amd64.tar.gz"
      sha256 "3cea04083edf79bb1bf8876da5db22b9ef0f2b8e72223c33d1c5d82b4ce85417"
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
