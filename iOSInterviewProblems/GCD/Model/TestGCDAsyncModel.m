//
//  TestGCDAsyncModel.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/20.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "TestGCDAsyncModel.h"

@implementation TestGCDAsyncModel

- (void)sendingAsyncConnect:(void (^)(NSString *testName))checkBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        if (checkBlock) {
            checkBlock(@"finish checking name");
        }
    });
}

@end
