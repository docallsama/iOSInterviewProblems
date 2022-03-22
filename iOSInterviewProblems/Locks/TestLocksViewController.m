//
//  TestLocksViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2022/3/22.
//  Copyright © 2022 谢艺欣. All rights reserved.
//
//  解决多读单写问题

#import "TestLocksViewController.h"
#include <pthread.h>

@interface TestLocksViewController ()

@property (nonatomic, assign) pthread_rwlock_t lock;

@end

@implementation TestLocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testUsePthreadRWLock];
}

#pragma mark - pthread_rwlock_t

- (void)testUsePthreadRWLock
{
    pthread_rwlock_init(&_lock, NULL);
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self testRead];
        });
        
        dispatch_async(queue, ^{
            [self testWrite];
        });
    }
}

- (void)testRead
{
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"read");
    pthread_rwlock_unlock(&_lock);
}

- (void)testWrite
{
    pthread_rwlock_wrlock(&_lock);
    sleep(1);
    NSLog(@"write");
    pthread_rwlock_unlock(&_lock);
}

#pragma mark - dispatch_barrier_async

- (void)dealloc
{
    pthread_rwlock_destroy(&_lock);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
