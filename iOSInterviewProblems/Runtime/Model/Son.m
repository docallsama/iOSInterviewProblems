//
//  Son.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/24.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Son.h"

@interface Son () {
    NSString *teacher;
}

@end

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        teacher = @"hundson";
    }
    return self;
}

@end
