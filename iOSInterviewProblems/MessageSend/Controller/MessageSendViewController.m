//
//  MessageSendViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/10.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "MessageSendViewController.h"
#import "Person.h"
#import "Person+MethodRun.h"
#import "NSObject+MethodB.h"
#import "NSObject+MethodA.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface MessageSendViewController ()

@end

@implementation MessageSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testRuntimeProperty];
    [self testMessageForward];
    [self testMessageSend];
    [self getInstanceMethod];
    [self testCategoryMethod];
}

- (void)testRuntimeProperty {
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"test run";
    NSLog(@"obj name -> %@",obj.name);
    [obj testMethod];
}

//消息转发机制
- (void)testMessageForward {
    Person *alen = [Person new];
    
    [alen run];
    //    [Person instanceRun];
}

//消息传递
- (void)testMessageSend {
    Person *alen = [Person new];
    NSString *returnString = ((NSString * (*)(id, SEL))(void *) objc_msgSend)((id)alen, @selector(normalRun));
    NSLog(@"return string -> %@",returnString);
}

//获取实体方法
- (void)getInstanceMethod {
    //获取实体方法
    unsigned int outcountMethod;
    id PersonClass = objc_getClass("Person");
    Method *methods = class_copyMethodList(PersonClass, &outcountMethod);
    for (int i = 0; i < outcountMethod; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        const char *selName = sel_getName(methodSEL);
        
        if (methodSEL) {
            NSLog(@"selector name -> %s",selName);
        }
    }
    free(methods);
    
    //获取类方法，未成功
    unsigned int numMethods;
    Method *classMethods = class_copyMethodList(objc_getMetaClass("Person"), &numMethods);
    for (int i = 0; i < numMethods; i++) {
        NSLog(@"class method name -> %@",NSStringFromSelector(method_getName(classMethods[i])));
    }
    free(classMethods);
}

//执行被category覆盖掉的原始方法
- (void)testCategoryMethod {
    Class currentClass = [Person class];
    Person *my = [[Person alloc] init];
    
    if (currentClass) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
                                                      encoding:NSUTF8StringEncoding];
            if ([@"normalRun" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void (*fn)(id,SEL);
        
        if (lastImp != NULL) {
            fn f = (fn)lastImp;
            f(my,lastSel);
        }
        free(methodList);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
