//
//  NotificationViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/8/25.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "NotificationViewController.h"
#import "CustomIntensityVisualEffectView.h"

NSString *const NOTIFICATION_TEST_MULTITHREAD = @"notification_test_multithread";

@interface NotificationViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self beginTestBlurView];
    [self beginTestNotification];
}

- (void)beginTestBlurView
{
    [self.view addSubview:self.bgImageView];
    
}

- (void)beginTestNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTestNotification:) name:NOTIFICATION_TEST_MULTITHREAD object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"register in thread -> %@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveResignNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"register in thread -> %@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TEST_MULTITHREAD object:nil];
    });
}

- (void)didReceiveResignNotification:(NSNotification *)notification
{
    NSLog(@"trigger -> b in thread -> %@", [NSThread currentThread]);
}

- (void)didReceiveTestNotification:(NSNotification *)notification
{
    NSLog(@"trigger -> multithread thread -> %@", [NSThread currentThread]);
}

#pragma mark - getter

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 250, 250)];
        _bgImageView.image = [UIImage imageNamed:@"ecs"];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        CustomIntensityVisualEffectView *effectView = [[CustomIntensityVisualEffectView alloc] initWithEffect:effect andIntensity:0.1];
        effectView.frame = CGRectMake(0, 0, 250, 250);
        [_bgImageView addSubview:effectView];
        
    }
    return _bgImageView;
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
