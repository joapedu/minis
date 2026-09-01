Prompt: Build and test

Purpose: developer-oriented commands to build locally and run tests.

Local build steps:
- Host build: `cargo build --workspace --release`
- Run tests: `cargo test --workspace`
- Format: `cargo fmt`

If a PR touches build configs, update `tools/` scripts and CI templates.
