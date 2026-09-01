//! Tiny core runtime helpers for the Tiny Rust Binaries framework.

pub fn init() {
    // Minimal panic hook that prints a short message.
    std::panic::set_hook(Box::new(|info| {
        eprintln!("Tiny core panic: {}", info);
    }));
}

/// Very small logging helper that keeps formatting minimal.
pub fn log(msg: &str) {
    // Use stderr for logs so stdout remains minimal for apps that pipe output.
    eprintln!("[tiny] {}", msg);
}
