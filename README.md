## Minis
### Tiny Rust Binaries Framework

This repository is a scaffold for building minimal, fast Rust binaries across major desktop and mobile platforms. It provides a small core runtime, thin platform launchers, example applications, cross-compilation helpers, CI configuration, and packaging utilities so engineers can focus on the application logic and produce small release artifacts.

Contents

1. Workspace manifest and release profile configured for size and reproducible builds. See `Cargo.toml`.
2. `core` crate with minimal runtime helpers used by examples and platform launchers.
3. `platform` subcrates with thin launchers or native entry points for Windows, macOS, Linux, Android and iOS.
4. `examples` showing a basic console app and mobile integration scaffolds for Android and iOS.
5. `tools` with scripts to build, package and measure artifacts.
6. CI workflows in `.github/workflows` that build the workspace, produce mobile artifacts and run size checks.

Repository layout

Top-level layout

1. `Cargo.toml` workspace manifest and `[profile.release]` tuned for size.
2. `core/` minimal runtime and helpers.
3. `platform/` platform-specific crates: `windows`, `linux`, `macos`, `android`, `ios`.
4. `examples/hello` simple example using the `core` crate.
5. `examples/android` minimal Gradle app skeleton that demonstrates where to place `libtiny_android.so`.
6. `examples/ios-spm` Swift Package Manager scaffold to help integrate `libtiny_ios.a` into Xcode.
7. `tools/` scripts: `release.sh`, `size-check.sh`, `sign-apk.sh`, `sign-ipa.sh`, and helper bootstrapping scripts.
8. `.github/workflows/ci.yml` CI pipeline that builds and collects artifacts.

How to build locally

Prerequisites

1. Rust and rustup installed and configured.
2. For Android native builds, install the Android NDK and `cargo-ndk`.
3. For iOS builds, use macOS with Xcode and install `cargo-lipo` for universal static libraries.

Build the workspace (host)

```bash
cargo build --workspace --release
```

Run the example

```bash
cd examples/hello
cargo run --release
```

Build Android native libraries

```bash
rustup target add aarch64-linux-android armv7-linux-androideabi
cargo install cargo-ndk
cargo ndk -t armeabi-v7a -t arm64-v8a --build --release --manifest-path platform/android/Cargo.toml
```

Build Android APK (Gradle)

1. Place the produced `libtiny_android.so` into `examples/android/app/src/main/jniLibs/<abi>/`.
2. Use the Gradle wrapper or the provided bootstrap script to assemble the debug APK.

```bash
cd examples/android
bash ./bootstrap-gradle-wrapper.sh
./gradlew assembleDebug
```

Build iOS universal static library (macOS)

```bash
cargo install cargo-lipo
cargo lipo --manifest-path platform/ios/Cargo.toml --release
```

The iOS build produces a universal `libtiny_ios.a`. Add it to an Xcode app or link it via the `examples/ios-spm` Swift package scaffold. A small Objective-C bridge is provided in `examples/ios/ExampleBridge.m` for reference.

CI and signing

The CI workflow builds the Rust workspace on Linux, Windows and macOS. It attempts Android native builds and runs `./tools/size-check.sh` to produce a size report. The CI includes jobs to assemble the Android app and upload the APK as an artifact.

Automatic signing

1. APK signing can be enabled by adding the following GitHub secrets to the repository: `APK_KEYSTORE_BASE64` and `APK_KEY_PASSWORD`.
2. iOS signing requires macOS runner credentials: `IOS_CERT_BASE64` and `IOS_PROFILE_BASE64` and additional code-signing configuration in Xcode. The repository includes `tools/sign-ipa.sh` to decode and stage signing materials for manual or scripted signing.

Security

1. Never commit keystores, private keys or provisioning profiles into the repository. Use encrypted CI secrets for automated signing.
2. The provided signing scripts decode base64-encoded secrets in CI and attempt to run signing tools. Review and adapt these scripts to match your signing workflows and key management policy.

Other notes

1. The repository contains placeholders and minimal scaffolds for platform integration. The mobile app projects are intentionally small and require an IDE project for full-featured development and provisioning.
2. The release scripts collect artifacts into `dist/` and produce a zip with iOS integration files and any built APKs when available.

Developer guidance

1. Format and lint before pushing: `cargo fmt` and `cargo clippy -- -D warnings`.
2. Run unit tests: `cargo test --workspace`.
3. Use the `.claude/SKILLS` files as operational notes for CI, cross-compilation and releases.

License

This repository is licensed under MIT. See the `LICENSE` file.

If you want, I can add more examples, tests, or a small benchmark to measure binary size and startup latency across targets.
You want tiny, fast Rust programs that run on every major desktop and mobile platform. This repo is a framework scaffold — opinionated, practical, and pragmatic.

Why this exists
- Because shipping small, maintainable native tools across platforms is still fiddly. This project aims to make it straightforward.

What you'll find here
- A small `core` runtime for minimal apps.
- Thin platform launchers for Windows, macOS, Linux, Android and iOS.
- Example apps that prove the approach and measure size.

How to get started (quick)

1. Install Rust and `rustup`.
2. Build the desktop example: `cargo build -p hello --release`.
3. Inspect `examples/` and read `plan.md` for the roadmap and design notes.

If you want help with a platform, say which one — I'll scaffold it for you.

Platform notes (expanded)

- Android: see `examples/android/README.md` — use `cargo-ndk` to produce `libtiny_android.so` and add it to an Android app's `jniLibs`.
- iOS: see `examples/ios/README.md` — use `cargo-lipo` on macOS to produce `libtiny_ios.a` and add it to your Xcode app, calling `tiny_ios_init()` from an ObjC/Swift bridge.


