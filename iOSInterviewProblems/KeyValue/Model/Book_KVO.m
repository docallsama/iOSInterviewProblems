//
//  Book_KVO.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/19.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Book_KVO.h"
#import <objc/message.h>
#import "TestKVViewController.h"

@implementation Book_KVO

- (void)setComment:(NSString *)comment {
    [super setComment:comment];
    
    id observer = objc_getAssociatedObject(self, @"observer");
    
    [observer ov_observeValueForKeyPath:@"comment" ofObject:self];
}

@end
