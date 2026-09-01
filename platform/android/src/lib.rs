// Minimal Android native library exposing a single symbol.
#![allow(non_snake_case)]

use std::ffi::CStr;

#[no_mangle]
pub extern "C" fn Java_org_tiny_Tiny_nativeHello(env: *mut std::os::raw::c_void, _obj: *mut std::os::raw::c_void) {
    // In real usage we'd interact via JNI. Keep minimal for the scaffold.
    tiny_core::init();
    tiny_core::log("Android native library started");
}
