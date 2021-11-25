//
//  CopyCustomClassViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/11/18.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import "CopyCustomClassViewController.h"
#import "ParentPerson.h"

@interface CopyCustomClassViewController ()

@property (nonatomic, copy) ParentPerson *subChild;

@end

@implementation CopyCustomClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testCopyNSArrayClass];
    [self testCustomCopyClass];
}

- (void)testCopyNSArrayClass
{
    NSArray *testArray = @[@"test"];
    NSArray *copyArray = [testArray copy];
    
    testArray = @[@"test1",@"test"];
    NSLog(@"test array -> %@ copy array -> %@", testArray, copyArray);
    
    NSMutableArray *testMutableArray = [[NSMutableArray alloc] init];
    [testMutableArray addObject:@"test"];
    NSMutableArray *copyMutableArray = [testMutableArray copy];
    NSLog(@"test muta array -> %@ copy muta array -> %@", testMutableArray, copyMutableArray);
    
    [testMutableArray addObject:@"test1"];
    
    NSLog(@"test muta array -> %@ copy muta array -> %@", testMutableArray, copyMutableArray);
    
}

- (void)testCustomCopyClass
{
    ParentPerson *parent = [[ParentPerson alloc] init];
    parent.name = @"test";
    parent.age = @"999";
    
    ParentPerson *child = [parent copy];
    NSLog(@"child name -> %@ age -> %@", child.name, child.age);
    
    child.name = @"test1";
    
    self.subChild = parent;
    
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
