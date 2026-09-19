# homebrew-tap

[![CI](https://github.com/fastbean-au/homebrew-tap/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/fastbean-au/homebrew-tap/actions/workflows/ci.yaml)
![Dependabot](https://img.shields.io/badge/dependabot-enabled-brightgreen)
[![Known Vulnerabilities](https://snyk.io/test/github/fastbean-au/homebrew-tap/badge.svg)](https://snyk.io/test/github/fastbean-au/homebrew-tap)

Homebrew formulae for [Hippocampus](https://github.com/fastbean-au/hippocampus) — a memory service
with intentional forgetting.

```sh
brew tap fastbean-au/tap

brew install fastbean-au/tap/hippocampus       # the service (+ `brew services start hippocampus`)
brew install fastbean-au/tap/hippocampus-cli   # the `hippo` command-line client
brew install fastbean-au/tap/hippocampus-mcp   # the Model Context Protocol bridge
```

These are prebuilt-binary formulae: each downloads the per-arch release tarball published by the
Hippocampus release workflow (macOS and Linux, amd64/arm64). `version` and the `sha256`s are bumped
from each release's `checksums.txt`.

## Running the service

```sh
brew services start hippocampus     # background via launchd/systemd, restarts on failure
brew services stop hippocampus
```

A default embedded-SQLite config is installed to `$(brew --prefix)/etc/hippocampus/config.json`
(preserved across upgrades) and the store lives under `$(brew --prefix)/var/hippocampus`. Edit the
config for a shared Postgres/MySQL, TLS, or auth, then restart the service.
