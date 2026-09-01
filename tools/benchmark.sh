#!/usr/bin/env bash
set -euo pipefail

# Simple benchmark harness
# Measures binary startup time and records sizes. Writes a CSV to dist/bench-results.csv

OUT=dist
mkdir -p "$OUT"
RESULTS="$OUT/bench-results.csv"
echo "binary,run,elapsed_ms,size_bytes" > "$RESULTS"

run_binary() {
  bin="$1"
  runs=${2:-10}
  if [ ! -f "$bin" ]; then
    echo "Binary not found: $bin"
    return
  fi
  size=$(stat -c%s "$bin" 2>/dev/null || stat -f%z "$bin")
  for i in $(seq 1 $runs); do
    start=$(date +%s%3N)
    "$bin" >/dev/null 2>&1 || true
    end=$(date +%s%3N)
    elapsed=$((end-start))
    echo "$(basename "$bin"),$i,$elapsed,$size" >> "$RESULTS"
  done
}

echo "Benchmark started: $(date)" > "$OUT/bench-log.txt"

# Example targets to measure
run_binary "target/release/hello" 5
run_binary "target/release/tiny-windows" 5
run_binary "target/release/tiny-linux" 5
run_binary "target/release/tiny-macos" 5

echo "Benchmarks written to $RESULTS"
