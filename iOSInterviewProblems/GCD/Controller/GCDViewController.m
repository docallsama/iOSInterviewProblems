//
//  GCDViewController.m
//  iOSInterviewProblems
//
//  Created by oliver on 2017/11/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMainQueue];
    [self testCombine];
}

//各种处理队列
- (void)getMainQueue {
    //获取主线程队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"reading now");
    });
    
    //获取global子线程队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"get global queue");
    });
    
    //获取global子线程队列
    dispatch_queue_t backGroundGlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(backGroundGlobalQueue, ^{
        NSLog(@"get background global queue");
    });
    
    //创建自定义队列
    dispatch_queue_t customQueue = dispatch_queue_create("com.uzai.testQueue", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    dispatch_async(customQueue, ^{
        NSLog(@"get custom queue");
    });
    
    //创建自定义队列
    dispatch_queue_t customSerialQueue = dispatch_queue_create("com.uzai.testSerialQueue", DISPATCH_QUEUE_SERIAL_WITH_AUTORELEASE_POOL);
    dispatch_sync(customQueue, ^{
        sleep(3);
        NSLog(@"custom serial queue %@",[NSThread currentThread]);
    });
    
    dispatch_sync(customQueue, ^{
        sleep(5);
        NSLog(@"custom serial queue 5 %@",[NSThread currentThread]);
    });
}

//通过信号量控制多线程同步
- (void)testCombine {
    dispatch_queue_t current1 = dispatch_queue_create("current1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t current2 = dispatch_queue_create("current2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t current3 = dispatch_queue_create("current3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    NSLog(@"current begin");
    
    //创建信号量 2 代表线程池中，最多有2个线程存在
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    dispatch_group_async(group, current1, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NSLog(@"current 1 finish %@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, current2, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NSLog(@"current 2 finish %@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, current3, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NSLog(@"current 3 finish %@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all finish");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
