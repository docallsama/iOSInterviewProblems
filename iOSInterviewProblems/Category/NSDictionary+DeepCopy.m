//
//  NSDictionary+DeepCopy.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSDictionary+DeepCopy.h"

@implementation NSDictionary (DeepCopy)

- (NSMutableDictionary *) mutableDeepCopy {
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc] initWithCapacity:self.count];
    NSArray * keys = [self allKeys];
    
    for(id key in keys) {
        id oneValue = [self objectForKey:key];
        id oneCopy = nil;
        
        if([oneValue respondsToSelector:@selector(mutableDeepCopy)]) {
            oneCopy = [oneValue mutableDeepCopy];
        }
        else if([oneValue respondsToSelector:@selector(mutableCopy)]) {
            oneCopy = [oneValue mutableCopy];
        }
        else {
            oneCopy = [oneValue copy];
        }
        [returnDict setValue:oneCopy forKey:key];
    }
    return returnDict;
}

@end
