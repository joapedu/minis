#!/usr/bin/env bash
set -euo pipefail

if [ -z "${IOS_CERT_BASE64:-}" ] || [ -z "${IOS_PROFILE_BASE64:-}" ]; then
  echo "iOS signing variables not set; skipping"
  exit 0
fi

echo "Decoding iOS cert and profile"
echo "$IOS_CERT_BASE64" | base64 -d > ios_cert.p12
echo "$IOS_PROFILE_BASE64" | base64 -d > profile.mobileprovision

echo "Note: IPA signing requires macOS Xcode tools and proper provisioning. This script places the artifacts for manual signing."
