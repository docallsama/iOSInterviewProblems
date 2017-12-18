//
//  RunloopViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/14.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "RunloopViewController.h"

@interface RunloopViewController () {
    
    __weak IBOutlet UIScrollView *ibMainScrollView;
    
}

@end

@implementation RunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ibMainScrollView.contentSize = CGSizeMake(300, 300);
    
    //与timer相关
//    [self testScheduledTimer];
//    [self testTimer];
//    [self testRunlLoopTimer];
//    [self testTimerWithFireDate];
    
    //自定义runloop
    [self testCustomRunloop];
}

#pragma mark - timer相关

//直接在当前runloop创建timer
- (void)testScheduledTimer {
    //使用selector调用
//    self.runloopTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    
    //使用invocation调用
    NSDictionary *params = @{@"name":@"alex",
                             @"pro":@"detective"};
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(timerFiringWithParam:)]];
    invocation.selector = @selector(timerFiringWithParam:);
    invocation.target = self;
    [invocation setArgument:&params atIndex:2];
    
    self.runloopTimer = [NSTimer scheduledTimerWithTimeInterval:2 invocation:invocation repeats:YES];
}

//创建timer，但没有加入runloop，只能生效一次，无法重复
- (void)testTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    [timer fire];
}

//timer 加入 runloop
- (void)testRunlLoopTimer {
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    self.runloopTimer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    [runloop addTimer:self.runloopTimer forMode:NSDefaultRunLoopMode];
}

//从指定时间启动的timer，此处展示5秒之后才开启定时器
- (void)testTimerWithFireDate {
    NSLog(@"hit schedule timer");
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSDate *futureDate = [NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]];
    self.runloopTimer = [[NSTimer alloc] initWithFireDate:futureDate interval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    [runloop addTimer:self.runloopTimer forMode:NSDefaultRunLoopMode];
}
                      
- (void)timerFiring {
    NSLog(@"runloop timer firing -> %@",[NSThread currentThread]);
}

- (void)timerFiringWithParam:(NSDictionary *)param {
    NSLog(@"runloop timer firing -> %@",param);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self performSelector:@selector(invalidateRunLoopTimer) onThread:self.socketThread withObject:nil waitUntilDone:YES];
}

- (void)invalidateRunLoopTimer {
    NSLog(@"invalidate current thread -> %@",[NSThread currentThread]);
    [self.runloopTimer invalidate];
    self.runloopTimer = nil;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - 自定义runloop

- (void)testCustomRunloop {
    self.socketThread = [[NSThread alloc] initWithTarget:self selector:@selector(socketMethod) object:nil];
    self.socketThread.name = @"com.uzai.socketThread";
    [self.socketThread start];
}

- (void)socketMethod {
    self.runloopTimer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addTimer:self.runloopTimer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)doFireTimer:(NSTimer *)timer {
    NSLog(@"doFireTimer -> %@",timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc");
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
