//
//  MethodCallResultViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/12/22.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "MethodCallResultViewController.h"
#import "Car.h"

@interface MethodCallResultViewController ()

@property (nonatomic, copy) NSString *golobalString;

@end

@implementation MethodCallResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testStringCallMethods];
    [self testObjectRelease];
}

//在方法内部修改外界传入的局部变量，只会作用于方法域之内
- (void)testStringCallMethods
{
    NSString *test = @"abc";
    NSArray *testArray = @[@"1"];
    self.golobalString = @"xyz";
    int num = 1;
    NSLog(@"test -> %@ testArray -> %@ num -> %d" ,test ,testArray ,num);
    // test -> abc testArray -> @"1" num -> 1
    [self changeString:test andTestArray:testArray andNum:num];
    NSLog(@"test -> %@ testArray -> %@ num -> %d" ,test ,testArray ,num);
    // test -> abc testArray -> @"1" num -> 1
}

- (void)changeString:(NSString *)string andTestArray:(NSArray *)testArray andNum:(int)num
{
    string = @"def";
    num = 2;
    testArray = @[@"2",@"3"];
    NSLog(@"test -> %@ testArray -> %@ num -> %d",string ,testArray ,num);
    // test -> def testArray -> @"2",@"3" num -> 2
}

- (void)testObjectRelease
{
    [self createAObject];
}

- (void)createAObject
{
    Car *benz = [[Car alloc] init];
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
