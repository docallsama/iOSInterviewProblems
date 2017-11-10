//
//  MessageSendViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/10.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "MessageSendViewController.h"
#import "Person.h"
#import "NSObject+MethodB.h"
#import "NSObject+MethodA.h"
#import <objc/runtime.h>

@interface MessageSendViewController ()

@end

@implementation MessageSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testRuntimeProperty];
    [self testMessageSend];
}

- (void)testRuntimeProperty {
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"test run";
    NSLog(@"obj name -> %@",obj.name);
    [obj testMethod];
}

//消息转发机制
- (void)testMessageSend {
    Person *alen = [Person new];
    
    [alen run];
    //    [Person instanceRun];
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
