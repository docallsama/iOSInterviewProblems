//
//  Book.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/18.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Book.h"

@interface Book () {
    int bookPageCount;
}

@end

@implementation Book


- (int)pageCount {
    return bookPageCount;
}

- (void)setPageCount:(int)pageCount {
    bookPageCount = pageCount;
}

//为了防止赋值时候传入nil
- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"pageCount"]) {
        [self setValue:@0 forKey:key];
    } else
        [super setNilValueForKey:key];
}

@end
