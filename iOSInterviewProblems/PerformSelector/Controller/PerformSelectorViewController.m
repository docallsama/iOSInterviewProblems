//
//  PerformSelectorViewController.m
//  iOSInterviewProblems
//
//  Created by oliver on 2020/8/2.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "PerformSelectorViewController.h"
#import "PerformedObject.h"
#import <Foundation/Foundation.h>

@interface PerformSelectorViewController ()

@end

@implementation PerformSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testPerformSelectorMethod];
}

#pragma mark - 测试performSelector

- (void)testPerformSelectorMethod
{
    //此处创建的performedObject，会在performSelector执行结束之后，释放
    //如未调用performSelector，则在testPerformSelectorMethod方法执行结束之后，释放
    PerformedObject *performedObject = [[PerformedObject alloc] init];
    [self performSelector:@selector(testAction:) withObject:performedObject afterDelay:3];
    
    NSLog(@"object after call method -> %@", performedObject);
}

- (void)testAction:(PerformedObject *)object
{
    NSLog(@"object in test action -> %@", object);
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
