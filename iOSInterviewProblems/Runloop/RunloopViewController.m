//
//  RunloopViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/14.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "RunloopViewController.h"
#import "Car.h"

@interface RunloopViewController () {
    
    __weak IBOutlet UIScrollView *ibMainScrollView;
    __weak IBOutlet UIImageView *ibContentImageView;
    BOOL shouldKeepRunning;
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
//    [self testCustomRunloop];
    [self testContinueRunloop];
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
    
    //普通timer关闭
    [self invalidateRunLoopTimer];
    
    //testCustomRunloop 关闭从thread启动的timer专用
//    [self performSelector:@selector(invalidateRunLoopTimer) onThread:self.socketThread withObject:nil waitUntilDone:NO];
}

- (void)invalidateRunLoopTimer {
    NSLog(@"invalidate current thread -> %@",[NSThread currentThread]);
    [self.runloopTimer invalidate];
    self.runloopTimer = nil;
    
    //testCustomRunloop 关闭从thread启动的timer专用
//    CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark - 自定义runloop

//子线程中启动定时器使用runloop保活
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

#pragma mark - 线程保活

- (void)testContinueRunloop
{
    shouldKeepRunning = YES;
    self.continueThread = [[RunloopThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    self.continueThread.name = @"com.soyoung.continueThread";
    [self.continueThread start];
}

- (void)run
{
    @autoreleasepool {
        CFRunLoopRef myCFRunLoop = CFRunLoopGetCurrent();
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
                switch (activity) {
                    case kCFRunLoopEntry:
                        NSLog(@"observer: loop entry");
                        break;
                    case kCFRunLoopBeforeTimers:
                        NSLog(@"observer: before timers");
                        break;
                    case kCFRunLoopBeforeSources:
                        NSLog(@"observer: before sources");
                        break;
                    case kCFRunLoopBeforeWaiting:
                        NSLog(@"observer: before waiting");
                        break;
                    case kCFRunLoopAfterWaiting:
                        NSLog(@"observer: after waiting");
                        break;
                    case kCFRunLoopExit:
                        NSLog(@"observer: exit");
                        break;
                    case kCFRunLoopAllActivities:
                        NSLog(@"observer: all activities");
                        break;
                    default:
                        break;
                }
            });
        CFRunLoopAddObserver(myCFRunLoop, observer, kCFRunLoopDefaultMode);
        
        /*如果不加这句，会发现runloop创建出来就挂了，因为runloop如果没有CFRunLoopSourceRef事件源输入或者定时器，就会立马消亡。
              下面的方法给runloop添加一个NSport，就是添加一个事件源，也可以添加一个定时器，或者observer，让runloop不会挂掉*/
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        /*不能使用 [[NSRunLoop currentRunLoop] run] 启动 runloop，会导致runloop无法退出*/
        while (shouldKeepRunning) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
}

- (void)testContinueRunloopMethod:(NSString *)testString
{
    NSLog(@"begin current thread -> %@ testString -> %@",[NSThread currentThread], testString);
    
    /* 此处若不添加 autoreleasepool 则对象不会在循环结束时释放，等到 testContinueRunloopMethod 方法执行完之后的 kCFRunLoopExit 再进行释放*/
    
    for (int i = 0; i < 999; i++) {
        @autoreleasepool {
            Car *benz = [[Car alloc] init];
            benz.model = @"suv";
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"testRunloop" ofType:@"png"];
            UIImage *displayImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
//            benz.displayImage = displayImage;
            [benz run];
        }
    }
    
    sleep(3);
    NSLog(@"end current thread -> %@ testString -> %@",[NSThread currentThread], testString);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(testContinueRunloopMethod:) onThread:self.continueThread withObject:@"test string" waitUntilDone:NO];
}

- (void)stopRunloop
{
    shouldKeepRunning = NO;
    NSLog(@"exit current thread -> %@", [NSThread currentThread]);
    self.continueThread = nil;
}

- (IBAction)onClickStopLoopButton:(UIButton *)sender {
    [self performSelector:@selector(stopRunloop) onThread:self.continueThread withObject:nil waitUntilDone:NO];
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
