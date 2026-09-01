Prompt: Cross-compile helper

Purpose: commands and conventions to cross-compile the tiny-binaries framework for Android, iOS, Windows and macOS. Link-first: point to tools and CI templates rather than copying long docs.

When asked to cross-compile:
- Prefer using the helper scripts in `tools/`.
- Android: `cargo install cargo-ndk` then `cargo ndk -t armeabi-v7a -t arm64-v8a -- build --release`
- iOS: build on macOS; prefer `cargo-lipo` for universal libraries: `cargo install cargo-lipo` then `cargo lipo --release`.
- Windows: use `x86_64-pc-windows-gnu` or MSVC toolchain depending on CI runner.

CI notes:
- Use GitHub Actions matrix with `ubuntu-latest`, `windows-latest`, `macos-latest` and an `android` job.
