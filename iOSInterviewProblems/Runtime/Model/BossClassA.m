//
//  BossClassA.m
//  iOSInterviewProblems
//
//  Created by oliver on 2022/5/21.
//  Copyright © 2022 谢艺欣. All rights reserved.
//

#import "BossClassA.h"
#define BOSSMIN(A,B) ((A) < (B) ? (A) : (B))

@implementation NSObject (Test)

+ (void)test {
    NSLog(@"aaaa");
}

- (void)test1 {
    NSLog(@"bbbb");
    
    float a = 1.0;
    float b = BOSSMIN(a++, 1.5);
    //a = 3.   b = 2
    
}

@end

@implementation BossClassA

- (void)dealloc
{
    NSLog(@"BossClassA dealloc");
}

- (void)testUserDetault
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    BOOL boolFlag = NO;
    [userdefaults setObject:@(boolFlag) forKey:@"boolFlag"];
    if ([userdefaults objectForKey:@"boolFlag"]) {
        BOOL eqByPass = [userdefaults objectForKey:@"boolFlag"];
        if (eqByPass) {
            NSLog(@"A");
        } else {
            NSLog(@"B");
        }
    } else {
        BOOL eqByPass = [userdefaults objectForKey:@"boolFlag"];
        if (eqByPass) {
            NSLog(@"C");
        } else {
            NSLog(@"D");
        }
    }
    // A
}

- (void)syncMain
{
    dispatch_queue_t quque = dispatch_queue_create("serial", nil);
    dispatch_async(quque, ^{
        NSLog(@"1");
    });
    dispatch_sync(quque, ^{
        NSLog(@"2");
    });
    
    dispatch_async(quque, ^{
        NSLog(@"3");
        dispatch_sync(quque, ^{
            NSLog(@"4");
        });
    });
    
    //调用此函数的输出是 1 2 3 崩溃
}

- (NSString *)getString
{
    return (__bridge NSString *)CFStringCreateWithCString(NULL, "h", kCFStringEncodingUTF8);
}

- (void)print
{
    NSLog(@"self.name = %@", self.name);
}

@end
