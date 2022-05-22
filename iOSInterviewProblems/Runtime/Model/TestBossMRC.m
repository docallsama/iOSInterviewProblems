//
//  TestBossMRC.m
//  iOSInterviewProblems
//
//  Created by oliver on 2022/5/21.
//  Copyright © 2022 谢艺欣. All rights reserved.
//

#import "TestBossMRC.h"

struct Person {
    char c;
    int a;
};

struct Student {
    char c;
    char d;
    int b;
};

@implementation TestBossMRC

+ (void)test
{
    NSString *a = @"abc";
    NSString *b = [a retain];
    NSString *c = [b copy];
    NSString *d = [c mutableCopy];
    NSString *e = [d copy];
    
    NSLog(@"retainCount a = %ld", (unsigned long)[a retainCount]); // -1
    NSLog(@"retainCount b = %ld", (unsigned long)[b retainCount]); // -1
    NSLog(@"retainCount c = %ld", (unsigned long)[c retainCount]); // -1
    NSLog(@"retainCount d = %ld", (unsigned long)[d retainCount]); // 1
    NSLog(@"retainCount e = %ld", (unsigned long)[e retainCount]); // -1
    
    //abc 地址相同 d 地址不同 e 地址也不同
    /*
     *
     (lldb) p a
     (__NSCFConstantString *) $0 = 0x000000010611df08 @"abc"
     (lldb) p b
     (__NSCFConstantString *) $1 = 0x000000010611df08 @"abc"
     (lldb) p c
     (__NSCFConstantString *) $2 = 0x000000010611df08 @"abc"
     (lldb) p d
     (__NSCFString *) $3 = 0x0000600001ec2130 @"abc"
     (lldb) p e
     (NSTaggedPointerString *) $4 = 0xe3ca7808d769f67e @"abc"

     */
    
    
    
}

@end
