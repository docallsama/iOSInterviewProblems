//
//  TestObject.m
//  iOSInterviewProblems
//
//  Created by oliver on 2020/10/8.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

//用于 rewrite 观察 arr runtime 时是什么样子
- (void)testBlockWithStack
{
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    static NSInteger num2 = 3;
    __block NSInteger num5 = 30000;
        
    void(^block)(void) = ^{
        
        NSLog(@"arr -> %@",arr);//局部变量
        NSLog(@"num2 -> %zd", num2);//static 修饰变量
        NSLog(@"num5 -> %zd", num5);//__block修饰变量
    };
    
    [arr addObject:@"3"];
    
    arr = nil;
    
    num2 = 2;
    num5 = 5;
    
    block();
}

@end
