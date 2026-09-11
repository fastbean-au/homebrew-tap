# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippocampus-mcp_v0.47.0_darwin_arm64.tar.gz"
      sha256 "0c6fcac2bcae6ee1f2d3e7e2a93676813b707e5c65845cffb253abc746b0d495"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippocampus-mcp_v0.47.0_darwin_amd64.tar.gz"
      sha256 "e2c5ef04d5c1a72f9d97ae14df01174816dc4b6ef0154013f0b961587f7c58c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippocampus-mcp_v0.47.0_linux_arm64.tar.gz"
      sha256 "cf9c05ac9b00c6726186f85b560c7170bae1451b45d1446ab085c649709c64f2"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.47.0/hippocampus-mcp_v0.47.0_linux_amd64.tar.gz"
      sha256 "bb803d8a8e69122b25da4f383b2b415c9890cacc71372e30ad5becfac7eb25e0"
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
