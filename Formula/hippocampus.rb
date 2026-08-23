# The Hippocampus service. A prebuilt-binary formula: it downloads the per-arch release tarball
# published by the repo's release workflow. version + sha256 are bumped from that release's
# checksums.txt (by hand or the repo's bump job). Installs a default embedded-SQLite config and a
# `brew services` definition so the service can run in the background.
class Hippocampus < Formula
  desc "Memory service with intentional forgetting (gRPC/HTTP)"
  homepage "https://github.com/fastbean-au/hippocampus"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus_v0.37.0_darwin_arm64.tar.gz"
      sha256 "e9251ab56be11e126ccb1edab814614be8e92428fb404f1c69f1cf23672c0c2e"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus_v0.37.0_darwin_amd64.tar.gz"
      sha256 "9dd2e92e82495726197d3a625d2ad9c498a1c5417f7d74b06b593079a1abd39d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus_v0.37.0_linux_arm64.tar.gz"
      sha256 "aa83b411d01fb993c1e9a0ef2143a83600cd5e1da92e44cfb4afcfc39cb7fa6f"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.37.0/hippocampus_v0.37.0_linux_amd64.tar.gz"
      sha256 "7e99588968d02f4713dc495f4fa96abe9a37b1c685953e4aa70756dc4ff7a918"
    end
  end

  def install
    bin.install "hippocampus"

    # Data directory the default config points at (SQLite database + WAL live here).
    (var/"hippocampus").mkpath

    # Install a default embedded-SQLite config, but never clobber an operator's edited one on
    # upgrade. storage.directory is written with the real Homebrew prefix (/usr/local vs
    # /opt/homebrew) via #{var}.
    config = etc/"hippocampus/config.json"
    unless config.exist?
      (etc/"hippocampus").mkpath
      config.write default_config
    end
  end

  # Kept in sync with deploy/systemd/config.json in the main repo; only storage.directory differs
  # (Homebrew's var). Held here rather than fetched from the repo so the formula does not depend on
  # source files existing at the tagged commit — only the released binary tarball does.
  def default_config
    <<~JSON
      {
          "logging": { "level": "info", "json": true },
          "port": 50051,
          "gateway": { "port": 8080 },
          "auth": { "method": "none", "signingSecret": "" },
          "tls": { "enabled": false, "certFile": "", "keyFile": "" },
          "storage": {
              "driver": "sqlite",
              "directory": "#{var}/hippocampus",
              "postgres": { "dsn": "" }
          },
          "memory": { "limit": { "sizeBytes": 1048576 }, "minimumSignificance": 0 },
          "event": { "minimumSignificance": 0 },
          "sleep": { "periodSeconds": 3600 },
          "consolidation": {
              "minimumAgeInDays": 14,
              "aggressiveness": 1.0,
              "deletionThreshold": 10,
              "method": 1,
              "unitsOfAgeInDays": 1.0,
              "relationshipSignificanceWeight": 1.0,
              "recallSignificanceWeight": 1.0,
              "capacityMemories": 100000,
              "capacityPressureExponent": 4.0
          }
      }
    JSON
  end

  def caveats
    <<~EOS
      Default config (embedded SQLite) installed to:
        #{etc}/hippocampus/config.json
      Memory store (SQLite database + WAL):
        #{var}/hippocampus

      Start in the background with:
        brew services start hippocampus
      or run in the foreground:
        hippocampus -c #{etc}/hippocampus/config.json

      gRPC on :50051, HTTP/JSON gateway (and /healthz) on :8080.
    EOS
  end

  service do
    run [opt_bin/"hippocampus", "-c", etc/"hippocampus/config.json"]
    keep_alive true
    working_dir var/"hippocampus"
    log_path var/"log/hippocampus/out.log"
    error_log_path var/"log/hippocampus/err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hippocampus --version 2>&1")
  end
end
