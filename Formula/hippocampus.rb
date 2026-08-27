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
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus_v0.38.2_darwin_arm64.tar.gz"
      sha256 "59f0377b6d75ec1da3e9d2fa0a3520a8c82991bfb891298413b3eca7a3d8b653"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus_v0.38.2_darwin_amd64.tar.gz"
      sha256 "56e856fa16d7424bd2e2938aa0dd4f26143525c47b9ca24997d68c8751ed10c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus_v0.38.2_linux_arm64.tar.gz"
      sha256 "d2e3714e2c10d59642676eda6a9c855f024e5e18c1fd8de2b0d88e70df75713c"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.38.2/hippocampus_v0.38.2_linux_amd64.tar.gz"
      sha256 "c6f931179ed18d6385fb3d71e7a5874abdf2a391ba3f597adb8d851cbafbaaa7"
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
