#!/usr/bin/env bash
set -euo pipefail

if [ -z "${APK_KEYSTORE_BASE64:-}" ]; then
  echo "APK_KEYSTORE_BASE64 not set; skipping signing"
  exit 0
fi

echo "Decoding keystore"
echo "$APK_KEYSTORE_BASE64" | base64 -d > signing.keystore

if [ ! -f "$1" ]; then
  echo "APK path required as first arg"
  exit 1
fi
APK="$1"

if command -v apksigner >/dev/null 2>&1; then
  apksigner sign --ks signing.keystore --ks-pass pass:$APK_KEY_PASSWORD "$APK"
else
  echo "apksigner not found; ensure Android build tools are installed in CI runner"
fi
