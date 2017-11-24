//
//  Father.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/24.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Father.h"

@interface Father () {
    NSString *employee;
}

@end

@implementation Father

- (instancetype)init {
    self = [super init];
    if (self) {
        employee = @"john";
    }
    return self;
}

- (void)doWork {
    
}

@end
