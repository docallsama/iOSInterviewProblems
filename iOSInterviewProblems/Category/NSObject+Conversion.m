//
//  NSObject+Conversion.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/30.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "NSObject+Conversion.h"

@implementation NSObject (Conversion)

- (void)ov_swizzleInstanceMethod:(SEL)origSeletor withMethod:(SEL)newSelector {
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, origSeletor);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    if (class_addMethod(cls,
                        newSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
