//
//  RuntimeViewController.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/11/24.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "RuntimeViewController.h"
#import "Son.h"
#import "Father.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInstanceVariable];
    [self getSuperClassInstanceVariable];
    [self getClassAllIvar];
    [self getClassProperty];
}

//获取类的成员变量
- (void)getInstanceVariable {
    Son *son = [[Son alloc] init];
    
    id sonClass = objc_getClass("Son");
    Ivar sonProperty = class_getInstanceVariable(sonClass, "teacher");
    NSString *teaher = object_getIvar(son, sonProperty);
    NSLog(@"teacher -> %@",teaher);
}

//获取父类的成员变量
- (void)getSuperClassInstanceVariable {
    Son *son = [[Son alloc] init];
    
    id sonClass = objc_getClass("Son");
    Class fatherClass = class_getSuperclass(sonClass);
    
    Ivar fatherProperty = class_getInstanceVariable(fatherClass, "employee");
    
    NSLog(@"fatherproperty => %@",object_getIvar(son, fatherProperty));
}

//获取类的ivar
- (void)getClassAllIvar {
    Son *son = [[Son alloc] init];
    son.bikeName = @"Giant";
    
    id sonClass = objc_getClass("Son");
    unsigned int outCount;
    Ivar *sonProperties = class_copyIvarList(sonClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar tempProperty = sonProperties[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(tempProperty)];
        NSString *ivarContent = object_getIvar(son, tempProperty);
        NSLog(@"propertyName -> %@ property content -> %@", ivarName, ivarContent);
    }
    free(sonProperties);
}

//获取类的property
- (void)getClassProperty {
    Son *son = [[Son alloc] init];
    son.bikeName = @"Melida";
    
    id sonClass = objc_getClass("Son");
    unsigned int outCount;
    objc_property_t *propertyList = class_copyPropertyList(sonClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSLog(@"propertyName -> %@ propertyAttributes -> %@", propertyName, propertyAttributes);
    }
    free(propertyList);
    
//    console output:
//    propertyName -> bikeName propertyAttributes -> T@"NSString",C,N,V_bikeName
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
