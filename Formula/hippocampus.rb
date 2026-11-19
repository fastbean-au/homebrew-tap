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
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus_v0.55.0_darwin_arm64.tar.gz"
      sha256 "369e595f5ae666338c98a02f4e19c26d0da4e98a971e1c9bf6ff59aab0236499"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus_v0.55.0_darwin_amd64.tar.gz"
      sha256 "9fe481d4d685994104654e8a65ce081de65484a34667043c8c709fd7906bae38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus_v0.55.0_linux_arm64.tar.gz"
      sha256 "5c5e6ce4579bd20fa4ecee48fea284f2e987a9a94ef8b56e4c5666140268d095"
    end
    on_intel do
      url "https://github.com/fastbean-au/hippocampus/releases/download/v0.55.0/hippocampus_v0.55.0_linux_amd64.tar.gz"
      sha256 "e546ef351aec8eff3040cd64cc814eaaac70271e9ce32c1b5798c36b8079275a"
    end
  end

  def install
    bin.install "hippocampus"

    # Data directory the default config points at (SQLite database + WAL live here).
    (var/"hippocampus").mkpath

    # Install a default embedded-SQLite config, but never clobber an operator's edited one on
    # upgrade. storage.directory is written with the real Homebrew prefix (/usr/local vs
    # /opt/homebrew) via #{var}.
    #
    # Kept in sync with deploy/systemd/config.json in the main repo; only storage.directory differs
    # (Homebrew's var). Held here rather than fetched from the repo so the formula does not depend
    # on source files existing at the tagged commit — only the released binary tarball does.
    config = etc/"hippocampus/config.json"
    unless config.exist?
      (etc/"hippocampus").mkpath
      config.write <<~JSON
        {
            "logging": { "level": "info", "json": true },
            "port": 50051,
            "bindAddress": "127.0.0.1",
            "gateway": { "port": 8080, "bindAddress": "127.0.0.1" },
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
                "linkSignificanceWeight": 1.0,
                "recallSignificanceWeight": 1.0,
                "capacityMemories": 100000,
                "capacityPressureExponent": 4.0
            }
        }
      JSON
    end
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

      gRPC on 127.0.0.1:50051, HTTP/JSON gateway (and /healthz) on 127.0.0.1:8080.
      Auth is off, so set auth.method before widening bindAddress / gateway.bindAddress.
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
