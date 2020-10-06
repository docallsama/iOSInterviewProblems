//
//  Son.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/24.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Son.h"

@interface Son () {
    NSString *teacher;
}

@end

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        teacher = @"hundson";
        
        //self 向上查找 class 方法实现，本身没有，则向 Father类查找，
        //Father类没有则再向上查找，直到查找到NSObject class 方法。
        //NSObject class 方法实现的是 object_getClass(self) ，故最终打印的是 Son
        //super 中调用的是 Father 类的 class 方法实现，则一样会查找到 NSObject 的 class 方法
        //最终打印的也是Son
        NSLog(@"self %@", NSStringFromClass([self class]));
        NSLog(@"super %@", NSStringFromClass([super class]));
    }
    return self;
}

- (void)doWork
{
    [super doWork];
}

- (void)configWhoIam
{
    NSLog(@"self -> %@, super -> %@", [self class], [super class]);
    //self -> Son, super -> Son
}

//如果 Son 中实现了 class 方法，则打印结果为 self -> RuntimeViewController super -> Son
//因为 self 调用的是 Son 中的 class 方法，而 super 则向上查找至 NSObject 的 class 方法

//如果 Father 中实现了 class 方法，则打印结果为 self -> Car super -> Car
//self 中未实现 class 方法，向上查找至 Father 的 class 方法，返回类 Car
//调用 super class 方法时，查找的 Father class 方法，返回类 Car

//- (Class)class
//{
//    return NSClassFromString(@"RuntimeViewController");
//}

@end
