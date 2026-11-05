#!/usr/bin/env bash
# Create an unsigned arm64 DMG from the Flutter macOS release build.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
VERSION="$("$ROOT/packaging/version.sh")"
APP_NAME="fLANexec"
APP_PATH="$ROOT/build/macos/Build/Products/Release/${APP_NAME}.app"
DIST_DIR="${DIST_DIR:-$ROOT/dist}"
DMG_NAME="flanexec-${VERSION}-macos-arm64.dmg"
STAGING="$(mktemp -d)"

cleanup() {
  rm -rf "$STAGING"
}
trap cleanup EXIT

if [[ ! -d "$APP_PATH" ]]; then
  echo "error: missing app bundle at $APP_PATH" >&2
  echo "run: flutter build macos --release" >&2
  exit 1
fi

mkdir -p "$DIST_DIR" "$STAGING"
cp -R "$APP_PATH" "$STAGING/"
ln -s /Applications "$STAGING/Applications"

# Replace any previous DMG so hdiutil create does not fail.
rm -f "$DIST_DIR/$DMG_NAME"

hdiutil create \
  -volname "$APP_NAME" \
  -srcfolder "$STAGING" \
  -ov \
  -format UDZO \
  "$DIST_DIR/$DMG_NAME"

echo "created $DIST_DIR/$DMG_NAME"
