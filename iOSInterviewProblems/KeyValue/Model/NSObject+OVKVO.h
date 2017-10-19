//
//  NSObject+OVKVO.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/19.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OVKVO)

- (void)ov_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
