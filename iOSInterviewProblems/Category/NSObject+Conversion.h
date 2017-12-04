//
//  NSObject+Conversion.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/30.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Conversion)

- (void)ov_swizzleInstanceMethod:(SEL)origSeletor withMethod:(SEL)newSelector;

@end
