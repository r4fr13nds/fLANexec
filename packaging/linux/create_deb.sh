#!/usr/bin/env bash
# Package the Flutter Linux release bundle as an amd64 .deb.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
VERSION="$("$ROOT/packaging/version.sh")"
BUNDLE="$ROOT/build/linux/x64/release/bundle"
DIST_DIR="${DIST_DIR:-$ROOT/dist}"
DEB_NAME="flanexec-${VERSION}-linux-amd64.deb"
STAGE="$(mktemp -d)/flanexec_${VERSION}_amd64"

cleanup() {
  rm -rf "$(dirname "$STAGE")"
}
trap cleanup EXIT

if [[ ! -d "$BUNDLE" ]]; then
  echo "error: missing Linux bundle at $BUNDLE" >&2
  echo "run: flutter build linux --release" >&2
  exit 1
fi

mkdir -p \
  "$STAGE/DEBIAN" \
  "$STAGE/opt/flanexec" \
  "$STAGE/usr/bin" \
  "$STAGE/usr/share/applications" \
  "$STAGE/usr/share/icons/hicolor/256x256/apps" \
  "$DIST_DIR"

cp -a "$BUNDLE/." "$STAGE/opt/flanexec/"

# Wrapper so PATH launches the bundled binary with correct relative libs.
cat > "$STAGE/usr/bin/flanexec" <<'EOF'
#!/bin/sh
exec /opt/flanexec/flanexec "$@"
EOF
chmod 755 "$STAGE/usr/bin/flanexec"
chmod 755 "$STAGE/opt/flanexec/flanexec"

cat > "$STAGE/usr/share/applications/flanexec.desktop" <<EOF
[Desktop Entry]
Name=fLANexec
Comment=LAN discovery and enumeration toolkit
Exec=flanexec
Icon=flanexec
Terminal=false
Type=Application
Categories=Network;Security;
StartupWMClass=flanexec
EOF

ICON_SRC="$ROOT/assets/icon/app_icon.png"
if [[ -f "$ICON_SRC" ]]; then
  cp "$ICON_SRC" "$STAGE/usr/share/icons/hicolor/256x256/apps/flanexec.png"
fi

# Installed-Size in KiB
INSTALLED_SIZE="$(du -sk "$STAGE/opt" "$STAGE/usr" | awk '{s+=$1} END {print s}')"

cat > "$STAGE/DEBIAN/control" <<EOF
Package: flanexec
Version: ${VERSION}
Section: net
Priority: optional
Architecture: amd64
Depends: libgtk-3-0, libblkid1, liblzma5
Installed-Size: ${INSTALLED_SIZE}
Maintainer: r4fr13nds <https://github.com/r4fr13nds/fLANexec>
Homepage: https://github.com/r4fr13nds/fLANexec
Description: LAN discovery and NetExec-style enumeration toolkit
 fLANexec is a multi-platform Flutter app for LAN host discovery,
 service detection, and protocol enumeration (SSH, SMB, LDAP, WinRM).
EOF

# Ensure package files are not group/world-writable (dpkg requirement).
chmod -R a+rX,u+w,go-w "$STAGE"

dpkg-deb --root-owner-group --build "$STAGE" "$DIST_DIR/$DEB_NAME"
echo "created $DIST_DIR/$DEB_NAME"
