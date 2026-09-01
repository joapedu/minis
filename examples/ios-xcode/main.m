#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

extern void tiny_ios_init(void);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        tiny_ios_init();
        NSLog(@"Tiny iOS Xcode scaffold called tiny_ios_init");
        return 0;
    }
}
