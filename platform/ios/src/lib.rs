// Minimal iOS static library scaffold that exposes a C-callable initializer.

#[no_mangle]
pub extern "C" fn tiny_ios_init() {
    tiny_core::init();
    tiny_core::log("iOS tiny lib initialized");
}
