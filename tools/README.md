# tools

Small helper scripts to orchestrate cross-platform builds. See `.claude/SKILLS/cross-compile/SKILL.md` for recommended commands.

Available scripts:
- `build-android.sh` — placeholder wrapper for Android builds (uses `cargo-ndk`).
- `build-ios.sh` — placeholder wrapper for iOS builds (uses `cargo-lipo`).
- `release.sh` — orchestrates release builds for host platforms and packages stripped artifacts.
