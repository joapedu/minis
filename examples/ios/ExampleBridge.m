// Minimal Objective-C bridge showing how to call the Rust symbol from an iOS app.
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
