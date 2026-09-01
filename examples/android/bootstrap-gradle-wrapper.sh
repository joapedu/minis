#!/usr/bin/env bash
set -euo pipefail

# Simple bootstrapper that downloads a specified Gradle distribution and creates a tiny wrapper
GRADLE_VERSION="7.4.0"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
WRAPPER_DIR="$BASE_DIR/gradle-wrapper"
DIST_ZIP="gradle-${GRADLE_VERSION}-bin.zip"
URL="https://services.gradle.org/distributions/${DIST_ZIP}"

mkdir -p "$WRAPPER_DIR"
cd "$WRAPPER_DIR"
if [ ! -f "$DIST_ZIP" ]; then
  echo "Downloading Gradle $GRADLE_VERSION..."
  curl -Ls "${URL}" -o "$DIST_ZIP"
fi
if [ ! -d "gradle-$GRADLE_VERSION" ]; then
  unzip -q "$DIST_ZIP"
fi

cat > "$BASE_DIR/gradlew" <<'EOF'
#!/usr/bin/env bash
DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$DIR/gradle-wrapper/gradle-7.4.0/bin/gradle" "$@"
EOF
chmod +x "$BASE_DIR/gradlew"

echo "Created gradlew wrapper at $BASE_DIR/gradlew"
