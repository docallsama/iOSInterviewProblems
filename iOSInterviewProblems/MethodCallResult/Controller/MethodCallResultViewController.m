//
//  MethodCallResultViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/12/22.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "MethodCallResultViewController.h"

@interface MethodCallResultViewController ()

@end

@implementation MethodCallResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testStringCallMethods];
}

- (void)testStringCallMethods
{
    NSString *test = @"abc";
    int num = 1;
    NSLog(@"test -> %@ num -> %d", test, num);
    [self changeString:test andNum:num];
    NSLog(@"test -> %@ num -> %d", test, num);
}

- (void)changeString:(NSString *)string andNum:(int)num
{
    string = @"def";
    num = 2;
    NSLog(@"test -> %@ num -> %d", string, num);
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
