# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippocampus-mcp_v0.54.1_darwin_arm64.tar.gz"
      sha256 "13ad3b063fd7b587fae209f58fc078c1c297aa20d033390275337866625c3415"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippocampus-mcp_v0.54.1_darwin_amd64.tar.gz"
      sha256 "f829e98f6ba63b9bc85769ff9101f5a42742e127d1e4aa828eece0a426a26bf8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippocampus-mcp_v0.54.1_linux_arm64.tar.gz"
      sha256 "5d7c4277f74e32f934c9fa0acfd12c74c259a0b391da2504ce1f46a760834d20"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.54.1/hippocampus-mcp_v0.54.1_linux_amd64.tar.gz"
      sha256 "2e48eac8664c476ddd4c639f68c19a851f55570b452bc29e3bf9960044f713b1"
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
