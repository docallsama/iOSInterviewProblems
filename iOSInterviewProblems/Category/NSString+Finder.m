//
//  NSString+Finder.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSString+Finder.h"

@implementation NSString (Finder)

- (NSArray *)getRangesRegExWithString:(NSString *)string {
    NSDate *beginDate = [NSDate date];
    NSMutableArray *returnArray = [NSMutableArray new];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:string
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    [regex enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        [returnArray addObject:[NSValue valueWithRange:match.range]];
    }];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"regex use date => %f",[endDate timeIntervalSince1970] - [beginDate timeIntervalSince1970]);
    
    return returnArray;
}


- (NSArray *)getRangesForLoopWithString:(NSString *)string {
    NSDate *beginDate = [NSDate date];
    NSMutableArray *returnArray = [NSMutableArray new];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring isEqualToString:string]) {
            [returnArray addObject:[NSValue valueWithRange:substringRange]];
        }
    }];
    
    NSDate *endDate = [NSDate date];
    NSLog(@"for loop use date => %f",[endDate timeIntervalSince1970] - [beginDate timeIntervalSince1970]);
    
    return returnArray;
}

@end
