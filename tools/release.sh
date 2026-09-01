#!/usr/bin/env bash
set -euo pipefail

echo "Release builder — builds release artifacts for host platforms and attempts to strip them."

mkdir -p dist

echo "Building workspace release..."
cargo build --workspace --release

echo "Copying host binaries to dist/"
# Copy examples and platform binaries if present
for bin in 
  target/release/hello 
  target/release/tiny-windows 
  target/release/tiny-linux 
  target/release/tiny-macos; do
  if [ -f "$bin" ]; then
    cp "$bin" dist/ || true
  fi
done

echo "Stripping binaries where possible..."
if command -v strip >/dev/null 2>&1; then
  for f in dist/*; do
    strip "$f" || true
  done
fi

echo "Collecting Android APK if present"
if [ -f "examples/android/app/build/outputs/apk/debug/app-debug.apk" ]; then
  cp examples/android/app/build/outputs/apk/debug/app-debug.apk dist/ || true
fi

echo "Collecting iOS static libraries if present"
if [ -f "platform/ios/target/universal/release/libtiny_ios.a" ]; then
  cp platform/ios/target/universal/release/libtiny_ios.a dist/ || true
fi

if [ -f "dist/libtiny_ios.a" ]; then
  echo "Packaging iOS integration zip"
  mkdir -p dist/ios
  cp examples/ios/ExampleBridge.m dist/ios/ || true
  cp dist/libtiny_ios.a dist/ios/ || true
  (cd dist && zip -r ios-integration.zip ios) || true
fi

echo "Release artifacts available in dist/"
