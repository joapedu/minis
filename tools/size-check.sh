#!/usr/bin/env bash
set -euo pipefail

echo "Size check — listing sizes of artifacts in dist/ and target/release"

REPORT=dist/size-report.txt
mkdir -p dist
echo "Size report generated at $(date)" > "$REPORT"

echo "Artifacts in dist/" >> "$REPORT"
if [ -d dist ]; then
  (cd dist && for f in *; do
    if [ -f "$f" ]; then
      echo "$f: $(stat -c%s "$f") bytes" >> "$REPORT"
    fi
  done)
fi

echo "Target release binaries" >> "$REPORT"
for f in target/release/*; do
  if [ -f "$f" ]; then
    echo "$(basename "$f"): $(stat -c%s "$f") bytes" >> "$REPORT"
  fi
done || true

echo "Report written to $REPORT"
