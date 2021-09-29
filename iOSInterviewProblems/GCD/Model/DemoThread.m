//
//  DemoThread.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/2/2.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import "DemoThread.h"

//评测题目: 无// 4个任务ABCD
// C依赖AB完成，期望尽量快执行完成
// D和ABC无关，期望尽量快执行完成所有任务

@implementation DemoThread

// ABCD 4个任务

+ (void)taskA:(NSString *)desc {
    NSLog(@"taskA begin, %@, %@", desc, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"taskA end, %@, %@", desc, [NSThread currentThread]);
}

+ (void)taskB:(NSString *)desc {
    NSLog(@"taskB begin, %@, %@", desc, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"taskB end, %@, %@", desc, [NSThread currentThread]);
}

+ (void)taskC:(NSString *)desc {
    NSLog(@"taskC begin, %@, %@", desc, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"taskC end, %@, %@", desc, [NSThread currentThread]);
}

+ (void)taskD:(NSString *)desc {
    NSLog(@"taskD begin, %@, %@", desc, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1.0];
    NSLog(@"taskD end, %@, %@", desc, [NSThread currentThread]);
}


+ (void)run4TaskNSThreadLock {
    // 4个任务ABCD
    // C依赖AB完成，使用 NSThread NSLock 实现
    // D和ABC无关，期望尽量快执行完成所有任务
    
    [NSThread detachNewThreadSelector:@selector(taskD:) toTarget:self withObject:@"D"];
    
    NSLock *lockA = [[NSLock alloc] init];
    NSLock *lockB = [[NSLock alloc] init];
    
    [NSThread detachNewThreadSelector:@selector(taskA:) toTarget:self withObject:@"A"];

    [NSThread detachNewThreadSelector:@selector(taskB:) toTarget:self withObject:@"B"];

    [NSThread detachNewThreadSelector:@selector(taskC:) toTarget:self withObject:@"C"];
    
    
}


+ (void)run4TaskOperation {
    // 4个任务ABCD
    // C依赖AB完成，使用 NSOperation NSOperationQueue 实现
    // D和ABC无关，期望尽量快执行完成所有任务
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    NSInvocationOperation *opD = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskD:) object:@"D"];
    [opD start];
    
    NSInvocationOperation *opA = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskA:) object:@"A"];
    
    NSInvocationOperation *opB = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskB:) object:@"B"];
    
    NSInvocationOperation *opC = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskC:) object:@"C"];
    
    [opC addDependency:opA];
    [opC addDependency:opB];
    
    [queue addOperation:opA];
    [queue addOperation:opB];
    [queue addOperation:opC];
}


+ (void)run4TaskGCD {
    // 4个任务ABCD
    // C依赖AB完成，使用 GCD 实现
    // D和ABC无关，期望尽量快执行完成所有任务
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self taskD:@"D"];
    });
    
    dispatch_queue_t current1 = dispatch_queue_create("current1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    //创建信号量 2 代表线程池中，最多有2个线程存在
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    dispatch_group_async(group, current1, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self taskA:@"A"];
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, current1, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self taskB:@"B"];
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self taskC:@"C"];
    });
}


// 判断两个字典对象 值完全相等
// lDic rDic key都是string类型，的value都是 plist 类型对象(instances of NSData, NSDate, NSNumber, NSString, NSArray, or NSDictionary)
// 子容器（NSArray, NSDictionary）的value也都是 plist 类型对象
// 要考虑循环引用情况, 比如 a(字典)-->b（数组）-->c（数组）-->a（字典）

+ (BOOL)testDicEqual:(NSDictionary *)lDic with:(NSDictionary *)rDic
{
    NSArray *lAllKeys = lDic.allKeys;
    NSArray *rAllKeys = rDic.allKeys;
    if (lAllKeys.count != rAllKeys.count) {
        return NO;
    }
    
    return YES;
}

@end
