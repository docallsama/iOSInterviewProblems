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
    [self testTimer];
}

- (void)testTimer {
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerFiring) userInfo:nil repeats:YES];
    [runloop addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
                      
- (void)timerFiring {
    NSLog(@"runloop timer firing");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
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
