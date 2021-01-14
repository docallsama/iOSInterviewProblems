//
//  MethodCallResultViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/12/22.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "MethodCallResultViewController.h"
#import "Car.h"

extern void _objc_autoreleasePoolPrint();
OBJC_EXTERN int _objc_rootRetainCount(id);

@interface MethodCallResultViewController ()

@property (nonatomic, copy) NSString *golobalString;
@property (nonatomic, strong) Car *bmw;

@end

@implementation MethodCallResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testStringCallMethods];
    [self createAObject];
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

//!!!此处结论是错误的!!!
- (void)testObjectRelease
{
    Car *carOne = [Car newBenz];
    Car *carTwo = [Car getBenz];
    // ...     /*方法结束时, ARC会自动插入[personOne release].想想是为什么?*/

    NSLog(@"benz -> retaincount %lu", _objc_rootRetainCount(carTwo));
    
    _objc_autoreleasePoolPrint();
    /*结果personOne没有加入autoreleasePool，personTwo加入了autoreleasePool*/

    

    NSLog(@"onePerson 0x%@", carTwo);
    NSLog(@"count: %zd",_objc_rootRetainCount(carTwo));

    /* personOne的引用计数1，personTwo的引用计数2*/
}

- (void)createAObject
{
    Car *benz = [Car newBenz];
    //不准确，打印不出来线程池中所有的对象
    _objc_autoreleasePoolPrint();
    NSLog(@"newPerson 0x%@", benz);
    //获取retaincount不一定准确
    NSLog(@"count: %zd",_objc_rootRetainCount(benz));
    [benz run];
    self.bmw = [[Car alloc] init];
    NSLog(@"current thread -> %@  benz -> %@ bmw -> %@", [NSThread currentThread], benz,self.bmw);
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
