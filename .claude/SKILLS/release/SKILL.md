Prompt: Release helper

Purpose: steps to cut a release and produce artifacts.

Release checklist (agent-friendly):
1. Bump version in `Cargo.toml` files.
2. Ensure CI passed on main.
3. Run `scripts/release.sh` (or `tools/release.yml`) to build for all platforms and upload artifacts.
4. Attach stripped binaries and checksums to the GitHub release.

Keep release steps deterministic and scripted.
