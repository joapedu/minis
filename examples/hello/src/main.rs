fn main() {
    // Initialize the tiny core runtime and demonstrate minimal output.
    tiny_core::init();
    tiny_core::log("hello example starting");
    println!("Hello from Tiny Rust Binaries — example app!");
}
