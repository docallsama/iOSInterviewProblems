//
//  Person.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/12.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

//未实现的实例run
- (void)run;

//正常的run写法
- (NSString *)normalRun;

//未实现的类run
+ (void)instanceRun;

@end
