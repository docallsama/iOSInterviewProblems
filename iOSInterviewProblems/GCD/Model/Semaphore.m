//
//  Semaphore.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/8.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Semaphore.h"

@interface WorkSigle: NSObject
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

- (void)wait;
- (void)signal;

@end
@implementation WorkSigle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)wait {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
};

- (void)signal {
    dispatch_semaphore_signal(self.semaphore);
}

@end

@implementation Semaphore

- (void)worker {
    //创建一个保存信号量的数组
    //假设有100个任务，那么有99个任务需要等待上一个任务结束
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 99; i++)
    {
        [array addObject:[WorkSigle new]];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_async(queue, ^{
            
            // do task
            [NSThread sleepForTimeInterval:arc4random() % 60 / 10.0];
            NSLog(@"do task %i time gap %f",i,arc4random() % 60 / 10.0);
            
            //wait a before task end
            if (i == 0) {
                //no before task
            } else {
                [array[i-1] wait];
            }
            
            //tell next task i'm end
            if (i == 100-1) {
                //no next
                //call back
                NSLog(@"call back %i",i);
            } else {
                
                [array[i] signal];
                //call back
                NSLog(@"call back %i",i);
            }
        });
    }
}

@end
