This is a minimal Android app skeleton demonstrating where to add the Rust native library built by `cargo-ndk`.

How to use:
1. Build the native library as described above (it produces `libtiny_android.so`).
2. Copy the `.so` files into `app/src/main/jniLibs/<abi>/libtiny_android.so`.
3. Open this folder in Android Studio or run `gradle assembleDebug` (you'll need a Gradle installation or the wrapper).

This skeleton includes:
- `app/src/main/java/org/tiny/MainActivity.java` — tiny activity that loads `libtiny_android` and calls the native entrypoint.
- `app/src/main/AndroidManifest.xml` — minimal manifest.

Notes: This is intentionally minimal; use Android Studio to generate a full project and copy these files in if you prefer.

This folder shows how to integrate a Rust native library built by `cargo-ndk` into an Android app.

High-level steps:

1. Install the Android NDK and `cargo-ndk`:

```bash
rustup target add aarch64-linux-android armv7-linux-androideabi
cargo install cargo-ndk
```

2. Build Rust library for Android ABIs:

```bash
cargo ndk -t armeabi-v7a -t arm64-v8a --build --release --manifest-path ../../platform/android/Cargo.toml
```

3. Copy the produced `libtiny_android.so` into your Android project's `app/src/main/jniLibs/<abi>/` folders and write a small Java/Kotlin wrapper that calls the JNI symbol `Java_org_tiny_Tiny_nativeHello`.

This repo provides `platform/android` as the native crate; the rest of the Android app (Gradle project) is left to users/IDE because full Android projects are large. Use this as a guide and the `tools/release.sh` to assemble APKs in CI if needed.
# Android example (scaffold)

This folder shows how to integrate a Rust native library built by `cargo-ndk` into an Android app.

High-level steps:

1. Install the Android NDK and `cargo-ndk`:

```bash
rustup target add aarch64-linux-android armv7-linux-androideabi
cargo install cargo-ndk
```

2. Build Rust library for Android ABIs:

```bash
cargo ndk -t armeabi-v7a -t arm64-v8a --build --release --manifest-path ../../platform/android/Cargo.toml
```

3. Copy the produced `libtiny_android.so` into your Android project's `app/src/main/jniLibs/<abi>/` folders and write a small Java/Kotlin wrapper that calls the JNI symbol `Java_org_tiny_Tiny_nativeHello`.

This repo provides `platform/android` as the native crate; the rest of the Android app (Gradle project) is left to users/IDE because full Android projects are large. Use this as a guide and the `tools/release.sh` to assemble APKs in CI if needed.
