//
//  PerformedObject.m
//  iOSInterviewProblems
//
//  Created by oliver on 2020/8/2.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "PerformedObject.h"

@implementation PerformedObject

- (void)dealloc
{
    NSLog(@"call destroy");
}

- (void)testNetRequest
{
    if (self.block) {
        self.block(@"test");
    }
}

@end
