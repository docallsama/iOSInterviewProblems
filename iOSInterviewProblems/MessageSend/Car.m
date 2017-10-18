//
//  Car.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/12.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Car.h"

@implementation Car

- (void)run {
    NSLog(@"car run");
}

+ (void)instanceRun {
    NSLog(@"instance car run");
}

- (void)methodWithObject:(NSString *)object andName:(NSString *)name andIsFull:(BOOL) isFull {
    NSLog(@"object -> %@ name -> %@ isFull -> %d", object, name, isFull);
}

@end
