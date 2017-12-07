//
//  GCDSingletonModel.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/7.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "GCDSingletonModel.h"

@implementation GCDSingletonModel

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)testModelOutput {
    NSLog(@"out put from singleton");
}

@end
