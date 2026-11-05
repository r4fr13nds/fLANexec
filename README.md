# fLANexec

[![CI](https://github.com/r4fr13nds/fLANexec/actions/workflows/ci.yml/badge.svg)](https://github.com/r4fr13nds/fLANexec/actions/workflows/ci.yml)
[![Latest release](https://img.shields.io/github/v/release/r4fr13nds/fLANexec)](https://github.com/r4fr13nds/fLANexec/releases/latest)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](LICENSE)

**fLANexec** is a multi-platform LAN discovery and enumeration toolkit built with Flutter. It combines fast host/service discovery (Nmap-style) with NetExec-inspired post-exploitation enumeration over SSH, SMB, LDAP, and WinRM.

## Platforms

| Platform | Artifact |
|----------|----------|
| Android | `.apk` |
| macOS (Apple Silicon) | `.dmg` |
| Linux (amd64) | `.deb` |
| Windows (x64) | Inno Setup `.exe` installer |

iOS project files exist in-repo, but IPA builds are not produced by CI.

## Features

### Network discovery
- Parallel ICMP and TCP host discovery with configurable concurrency
- CIDR expansion (up to `/16`) with smart IP generation
- DNS + mDNS hostname resolution
- Automatic Active Directory Domain Controller badging

### Service detection
- Nmap-style service/version/OS dashboard
- Deep probes for SSH, HTTP/HTTPS, FTP, SMTP, DNS, and SMB
- Banner grabbing and HTTP title / SSH key / AD RootDSE extraction

### Protocol enumeration
- **SSH** — connection and host enumeration
- **SMB** — hostname probing and share/session enumeration
- **LDAP** — domain info and group resolution
- **WinRM** — remote Windows enumeration

## Install from releases

Download the latest build from [GitHub Releases](https://github.com/r4fr13nds/fLANexec/releases/latest):

| File | Platform |
|------|----------|
| `flanexec-<version>-android.apk` | Android |
| `flanexec-<version>-macos-arm64.dmg` | macOS arm64 |
| `flanexec-<version>-linux-amd64.deb` | Debian/Ubuntu amd64 |
| `flanexec-<version>-windows-x64-setup.exe` | Windows x64 |

### Unsigned binaries

Release builds are **not code-signed**.

- **macOS:** Gatekeeper will block the app. Right-click → Open, or remove quarantine after verifying the download: `xattr -dr com.apple.quarantine /Applications/fLANexec.app`
- **Windows:** SmartScreen may warn on first run. Choose “More info” → “Run anyway” if you trust the release.
- **Android:** Enable install from unknown sources for your browser/file manager, then install the APK.
- **Linux:** Install with `sudo apt install ./flanexec-*-linux-amd64.deb` (or `dpkg -i`).

## Build from source

Requirements: [Flutter](https://docs.flutter.dev/get-started/install) (stable), platform toolchains for the targets you build.

```bash
git clone https://github.com/r4fr13nds/fLANexec.git
cd fLANexec
flutter pub get
```

```bash
# Android
flutter build apk --release

# macOS (Apple Silicon)
flutter build macos --release
./packaging/macos/create_dmg.sh

# Linux
flutter build linux --release
./packaging/linux/create_deb.sh

# Windows (from a Windows host / CI)
flutter build windows --release
# then compile packaging/windows/flanexec.iss with Inno Setup
```

Packaged artifacts are written under `dist/`.

## CI / releases

- **CI** (`.github/workflows/ci.yml`): on push/PR to `main` — analyze, test, and build Android, Linux, macOS, and Windows.
- **Release** (`.github/workflows/release.yml`): on tags `v*` (e.g. `v1.0.0`) — build packages and publish a GitHub Release.

Keep the tag version aligned with `version:` in `pubspec.yaml` (e.g. tag `v1.0.0` ↔ `1.0.0+1`).

```bash
git tag v1.0.0
git push origin v1.0.0
```

## License

GPL-3.0 — see [LICENSE](LICENSE).
