//
//  Person.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/12.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "Person.h"
#import "Car.h"
#import <objc/runtime.h>
#import "Person+MethodRun.h"

@interface Person () {
    Car *jeep;
}

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        jeep = [Car new];
        [jeep performSelector:@selector(methodWithObject:andName:andIsFull:) withObject:@"light" withObject:@"DOC"];
    }
    return self;
}

void run (id self, SEL _cmd) {
    NSLog(@"%@ %s", self, sel_getName(_cmd));
}

- (void)fakeRun {
    NSLog(@"fake run");
}

- (NSString *)normalRun {
    NSLog(@"normal run");
    return @"normal run";
}

- (void)innerMethod {
    NSLog(@"using inner Method");
}

//原始方法
- (void)originalMethodRun {
    NSLog(@"perform original method run");
}

//替换的方法
- (void)swizzledMethodRun {
    NSLog(@"perform swizzled method run");
}

#pragma mark - 方法拦截

//第一次拦截
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(run)) {
//        //两种替换的方法
//
//        //方法1：使用C语言方法
////        class_addMethod(self, sel, (IMP)run, "v@:");
//        
//        //方法2：使用OC方法
//        class_addMethod(self, sel, class_getMethodImplementation([Person class], @selector(fakeRun)), "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

//第二次拦截
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    
//    return self;
//}

//第三次拦截
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    if ([jeep methodSignatureForSelector:selector]) {
        [anInvocation invokeWithTarget:jeep];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    if ([Car methodSignatureForSelector:selector]) {
        
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [jeep methodSignatureForSelector:aSelector];
    // invocation 有2个隐藏参数，所以 argument 从2开始
    NSLog(@"now calling -> %@ \n numberOfArguments -> %zd \n returnType -> %@", NSStringFromSelector(aSelector), signature.numberOfArguments - 2, [[NSString alloc] initWithUTF8String:signature.methodReturnType]);
    return signature;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"now calling -> %@",NSStringFromSelector(aSelector));
    NSMethodSignature *signature = [Car methodSignatureForSelector:aSelector];
//    NSMethodSignature *signature = [Car instanceMethodSignatureForSelector:aSelector];
    return signature;
}

@end
