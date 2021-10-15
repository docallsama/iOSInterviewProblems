//
//  AnimationViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/10/14.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import "AnimationViewController.h"
#import "AnimationSubClassView.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet AnimationSubClassView *ibAnimationView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - action

- (IBAction)onClickStartAnimationButton:(id)sender {
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.ibAnimationView.frame = CGRectMake(23, 500, 100, 100);
    } completion:nil];
}

- (IBAction)onClickAnimatedButton:(id)sender {
    NSLog(@"trigger animation");
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
