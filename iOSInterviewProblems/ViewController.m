//
//  ViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/9/25.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "ViewController.h"
#import "TestLayoutView.h"
#import "NSString+Finder.h"
#import "NSDictionary+DeepCopy.h"
#import "HitTestView.h"

@interface ViewController () {
    HitTestView *hitTestView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    TestLayoutView *layoutView = [[TestLayoutView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    TestLayoutView *layoutView = [[TestLayoutView alloc] init];
    layoutView.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:layoutView];
    [layoutView drawOnePixelLine];
    
    [layoutView changeViewLayout];
    [layoutView changeViewSize];
//    layoutView.frame = CGRectMake(0, 0, 100, 100);
    [self testMultableHiglightedInLabel];
    [self testDeepCopyWithDictionary];
    
//    [self testFindStringInChapter];
    
    [self copyNSString];
    
    [self createHitTestView];
//    [self removeHitTestViewAfterDelay];
    
    [self createButtonWithGesture];
}

//测试正则与for循环查找文字的速度
- (void)testFindStringInChapter {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"testString" ofType:@"txt"];
    NSString *rawString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *targetString = @"柳妍";
    NSArray <NSValue *> *array = [rawString getRangesRegExWithString:targetString];
    NSLog(@"regex Array -> %@",array);
    NSArray <NSValue *> *tempArray = [rawString getRangesForLoopWithString:targetString];
    NSLog(@"for loop Array -> %@",tempArray);
}

//查找到文字之后再进行高亮操作
- (void)testMultableHiglightedInLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 20)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
//    NSString *rawString = @"再点搜索，检查搜框";
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"testString" ofType:@"txt"];
    NSString *rawString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:rawString];
    
    NSArray <NSValue *> *array = [rawString getRangesRegExWithString:@"柳妍"];
    NSArray <NSValue *> *tempArray = [rawString getRangesForLoopWithString:@"柳妍"];
    if ([array count]) {
        for (int i = 0; i < [array count]; i++) {
            NSRange hitRange = array[i].rangeValue;
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:hitRange];
        }
    }
    label.attributedText = attributedString;
}

//对immutable dic 进行 深度拷贝，通过递归将内部所有dic都进行mutablecopy
- (void)testDeepCopyWithDictionary {
    NSDictionary *rawDic = @{@"key":@{@"key":@"value",
                                      @"key1":@"value1"},
                             @"subKey":@{@"subKey":@"subValue"}};
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    mutableDic = [rawDic mutableDeepCopy];
    NSMutableDictionary *innerDic = mutableDic[@"key"];
    [innerDic setObject:@"value2" forKey:@"key2"];
    NSLog(@"innerDic -> %@",innerDic);
}

- (void)viewDidLayoutSubviews {
    
}

- (void)copyNSString {
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"432432"];
    id mutablecopyString = [mutableString copy];
    NSLog(@"string -> %@",[mutablecopyString class]);
    
    NSString *string = [NSString stringWithFormat:@"123123"];
    id copyString = [string mutableCopy];
    NSLog(@"string -> %@",[copyString class]);
    
}

#pragma mark - hittest

//hittestview上的button就算超出view的frame也会被捕获到
- (void)createHitTestView {
    hitTestView = [[HitTestView alloc] initWithFrame:CGRectMake(0, 350, 200, 60)];
    hitTestView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:hitTestView];
    
    UIButton *largeButton = [[UIButton alloc] initWithFrame:CGRectMake(100, -100, 50, 140)];
    [largeButton addTarget:self action:@selector(onClickHittestButton) forControlEvents:UIControlEventTouchUpInside];
    largeButton.backgroundColor = [UIColor blueColor];
    [hitTestView addSubview:largeButton];
    
}

- (void)onClickHittestButton {
    NSLog(@"click hittest button");
}

- (void)removeHitTestViewAfterDelay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hitTestView removeFromSuperview];
    });
}

#pragma mark - responder

//按钮上再添加 tapgesture 之后，只相应 tapgesture 的点击事件
- (void)createButtonWithGesture
{
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.backgroundColor = [UIColor purpleColor];
    testButton.frame = CGRectMake(300, 350, 200, 60);
    [testButton addTarget:self action:@selector(onClickTestButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTapGesture)];
    [testButton addGestureRecognizer:tapRecognizer];
}

- (void)onClickTestButton
{
    NSLog(@"did select test button");
}

- (void)onClickTapGesture
{
    NSLog(@"did select tap gesture");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
