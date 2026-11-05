#!/usr/bin/env bash
# Print the pubspec version without the +build suffix (e.g. 1.0.0+1 -> 1.0.0).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_LINE="$(grep -E '^version:' "$ROOT/pubspec.yaml" | head -n1)"
VERSION="${VERSION_LINE#version:}"
VERSION="$(echo "$VERSION" | tr -d '[:space:]')"
VERSION="${VERSION%%+*}"

if [[ -z "$VERSION" ]]; then
  echo "error: could not parse version from pubspec.yaml" >&2
  exit 1
fi

echo "$VERSION"
