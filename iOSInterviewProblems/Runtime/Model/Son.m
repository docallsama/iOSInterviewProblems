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
        
        NSLog(@"self %@", NSStringFromClass([self class]));
        NSLog(@"super %@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)doWork
{
    [super doWork];
}

- (void)configWhoIam
{
    NSLog(@"self -> %@, super -> %@", [self class], [super class]);
    //self -> Son, super -> Son
}

@end
