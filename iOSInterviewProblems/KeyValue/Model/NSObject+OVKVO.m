//
//  NSObject+OVKVO.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/19.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSObject+OVKVO.h"
#import <objc/message.h>
#import "Book_KVO.h"

@implementation NSObject (OVKVO)

- (void)ov_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    object_setClass(self, [Book_KVO class]);
    
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
