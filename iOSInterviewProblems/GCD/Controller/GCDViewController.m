//
//  GCDViewController.m
//  iOSInterviewProblems
//
//  Created by oliver on 2017/11/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDSingletonModel.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMainQueue];
    [self doMutipleTimesWork];
    [self createSingletonModel];
    [self testCombineWithSemaphore];
    [self testCombineWithEnter];
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
    dispatch_queue_t customQueue = dispatch_queue_create("com.uzai.testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(customQueue, ^{
        NSLog(@"get custom queue");
    });
    
    //创建自定义队列
    dispatch_queue_t customSerialQueue = dispatch_queue_create("com.uzai.testSerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(customSerialQueue, ^{
        sleep(3);
        NSLog(@"custom serial queue %@",[NSThread currentThread]);
    });
    
    dispatch_async(customSerialQueue, ^{
        sleep(5);
        NSLog(@"custom serial queue 5 %@",[NSThread currentThread]);
    });
}

//for循环block
- (void)doMutipleTimesWork {
    dispatch_queue_t asyncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(5, asyncQueue, ^(size_t currentSize) {
        NSLog(@"current size -> %zu",currentSize);
    });
}

//使用gcd创建单例
- (void)createSingletonModel {
    [[GCDSingletonModel shareInstance] testModelOutput];
}

//通过信号量控制多线程同步
- (void)testCombineWithSemaphore {
    //三个并行队列，完成时收到回调
    dispatch_queue_t current1 = dispatch_queue_create("current1", DISPATCH_QUEUE_CONCURRENT);
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
    
    dispatch_group_async(group, current1, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NSLog(@"current 2 finish %@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_async(group, current1, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        sleep(3);
        NSLog(@"current 3 finish %@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all finish");
    });
    
    //output
    //2017-12-07 15:57:59.207 iOSInterviewProblems[64337:3876851] current 1 finish <NSThread: 0x60800026f6c0>{number = 9, name = (null)}
    //2017-12-07 15:58:02.282 iOSInterviewProblems[64337:3945895] current 2 finish <NSThread: 0x600000270800>{number = 12, name = (null)}
    //2017-12-07 15:58:02.282 iOSInterviewProblems[64337:3875012] all finish
}

//使用enter，leave控制
- (void)testCombineWithEnter {
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.uzai.download", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 6; i++) {
        dispatch_group_enter(downloadGroup);
        dispatch_async(downloadQueue, ^{
            NSLog(@"now downloading");
            sleep(i);
            dispatch_group_leave(downloadGroup);
            NSLog(@"downloaded");
        });
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"all download done");
    });
    
//    output
//    2017-12-07 17:06:24.765 iOSInterviewProblems[65166:3996044] now downloading
//    2017-12-07 17:06:24.765 iOSInterviewProblems[65166:3995991] now downloading
//    2017-12-07 17:06:24.765 iOSInterviewProblems[65166:3995994] now downloading
//    2017-12-07 17:06:24.765 iOSInterviewProblems[65166:3996044] downloaded
//    2017-12-07 17:06:24.765 iOSInterviewProblems[65166:3996047] now downloading
//    2017-12-07 17:06:24.766 iOSInterviewProblems[65166:3996044] now downloading
//    2017-12-07 17:06:24.766 iOSInterviewProblems[65166:3996048] now downloading
//    2017-12-07 17:06:25.840 iOSInterviewProblems[65166:3995991] downloaded
//    2017-12-07 17:06:26.766 iOSInterviewProblems[65166:3995994] downloaded
//    2017-12-07 17:06:27.840 iOSInterviewProblems[65166:3996047] downloaded
//    2017-12-07 17:06:28.766 iOSInterviewProblems[65166:3996044] downloaded
//    2017-12-07 17:06:29.767 iOSInterviewProblems[65166:3996048] downloaded
//    2017-12-07 17:06:29.767 iOSInterviewProblems[65166:3995950] all download done
    
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
