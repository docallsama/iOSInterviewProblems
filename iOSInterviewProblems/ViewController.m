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

@interface ViewController ()

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
