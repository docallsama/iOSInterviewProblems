//
//  NSObject+MethodA.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSObject+MethodA.h"
#import <objc/message.h>

@implementation NSObject (MethodA)

- (void)testMethod {
    NSLog(@"Method A called");
}

+ (void)load
{
    NSLog(@"load A now");
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSString *)name {
    return objc_getAssociatedObject(self, _cmd);
}

@end
