//
//  Car.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/12.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic,copy)NSString *model;

- (void)run;

+ (void)instanceRun;

- (void)methodWithObject:(NSString *)object andName:(NSString *)name andIsFull:(BOOL) isFull;

@end
