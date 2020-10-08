//
//  NSObject+MethodB.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSObject+MethodB.h"

@implementation NSObject (MethodB)

- (void)testMethod {
    NSLog(@"Method B called");
}

+ (void)load
{
    NSLog(@"load B now");
}

@end
