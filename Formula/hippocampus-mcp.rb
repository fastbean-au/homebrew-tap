# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippocampus-mcp_v0.49.0_darwin_arm64.tar.gz"
      sha256 "104ee87ea589eb016e3b441c9813709089583145b1c71d6b1f660795c8242902"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippocampus-mcp_v0.49.0_darwin_amd64.tar.gz"
      sha256 "3aeeb782a05d920f09735d2ed8757bb7ae269a155d4ee8653208197e596954c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippocampus-mcp_v0.49.0_linux_arm64.tar.gz"
      sha256 "0708ba50beb97966ba28bfb70abbd3e5671c0167af4a46a3d94013b2058e8501"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.49.0/hippocampus-mcp_v0.49.0_linux_amd64.tar.gz"
      sha256 "c5f31265656869ac65be5a97a9e91deb755a8fb2694540a7ca570f643c6eca7c"
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
