# AGENTS.md — Guidance for AI coding agents

Purpose: short, focused instructions so an AI agent can quickly be productive in this repository.

- **Build:** Use `cargo` and the scripts in `tools/` to build. Prefer `cargo build --release` for artifacts. For Android use `tools/build-android.sh`; for iOS use macOS runner and `tools/build-ios.sh`.
- **Tests:** Run `cargo test --workspace` on host runners only.
- **Cross-compile:** See `.claude/SKILLS/cross-compile/SKILL.md` for exact commands and CI links.
- **Preserve docs:** Link to existing docs — do not copy large guides into AGENTS.md.
- **Minimal edits:** When generating code, keep changes small and focused; prefer adding new files over editing many existing files.

If unsure, open an issue before large refactors.
