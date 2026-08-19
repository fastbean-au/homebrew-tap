# The standalone Model Context Protocol bridge (`hippocampus-mcp`). A prebuilt-binary formula: it
# downloads the per-arch release tarball published by the hippocampus repo's release workflow.
# version + sha256 are bumped from that release's checksums.txt (by hand or the repo's bump job).
class HippocampusMcp < Formula
  desc "Model Context Protocol bridge for the Hippocampus memory service"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippocampus-mcp_v0.35.1_darwin_arm64.tar.gz"
      sha256 "5a728aa62776e262678e0555fd2b96de379aae7c6e596fc1f6450e47723a13cb"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippocampus-mcp_v0.35.1_darwin_amd64.tar.gz"
      sha256 "c845ad5fadcfc80127bdd2ae297740a74030a4b33d0c1463ecfb6c532df5a276"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippocampus-mcp_v0.35.1_linux_arm64.tar.gz"
      sha256 "9a4b5c35f2a07525d64c952fb836e03639d766ac9093cf8aa81305a1927371ec"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.35.1/hippocampus-mcp_v0.35.1_linux_amd64.tar.gz"
      sha256 "546c041f5dcd181a81ad556149e8529f3684d76ca18537889ffa583d8729bd71"
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
