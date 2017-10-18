//
//  NSString+Finder.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Finder)

//正则表达式
- (NSArray *)getRangesRegExWithString:(NSString *)string;

//for循环
- (NSArray *)getRangesForLoopWithString:(NSString *)string;

@end
