# iOS example (scaffold)

This folder shows how to integrate the `tiny_ios` static library into an Xcode project.

High-level steps:

1. Build iOS universal static library on macOS with `cargo-lipo`:

```bash
cargo install cargo-lipo
cargo lipo --manifest-path ../../platform/ios/Cargo.toml --release
```

2. `cargo-lipo` will produce a universal static lib (e.g. `libtiny_ios.a`). Add it to an Xcode app target and create a small Objective-C or Swift bridge calling the `tiny_ios_init()` symbol. See `ExampleBridge.m` for a tiny Objective-C example.

3. Example Objective-C bridge (included in this folder as `ExampleBridge.m`) :

```objc
#import <Foundation/Foundation.h>

extern void tiny_ios_init(void);

@interface TinyBridge : NSObject
- (void)start;
@end

@implementation TinyBridge
- (void)start {
    tiny_ios_init();
}
@end
```

Because Xcode project files are large and user-specific, this repo keeps the native crate in `platform/ios` and documents the integration steps here.
