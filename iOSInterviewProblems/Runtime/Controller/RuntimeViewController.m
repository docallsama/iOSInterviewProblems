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
#import "Car.h"

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
    [self addPropertyForCar];
    [self addInstanceVariableForCar];
}

#pragma mark - 属性相关操作

//获取类的成员变量
- (void)getInstanceVariable {
    Son *son = [[Son alloc] init];
    
    id sonClass = objc_getClass("Son");
    Ivar sonProperty = class_getInstanceVariable(sonClass, "teacher");
    NSString *teaher = object_getIvar(son, sonProperty);
    NSLog(@"teacher -> %@",teaher);
    
    object_setIvar(son, sonProperty, @"snow ball");
    teaher = object_getIvar(son, sonProperty);
    NSLog(@"teacher after change -> %@",teaher);
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

//为car类添加property
- (void)addPropertyForCar {
    //1
    Car *fit = [Car new];
    objc_setAssociatedObject(fit, @selector(speed), @"80", OBJC_ASSOCIATION_COPY);
    NSString *speed = objc_getAssociatedObject(fit, @selector(speed));
    
    NSLog(@"fit current speed -> %@",speed);
//    console output:
//    fit current speed -> 80
    
    //2
    id carClass = objc_getClass("Car");
    
    @autoreleasepool {
        objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([NSString class])] UTF8String] }; //type
        objc_property_attribute_t ownership0 = { "C", "" }; // C = copy
        objc_property_attribute_t ownership = { "N", "" }; //N = nonatomic
        objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", @"speed"] UTF8String] };  //variable name
        objc_property_attribute_t attrs[] = { type, ownership0, ownership, backingivar };
        
        BOOL isSuccess = class_addProperty(carClass, "speed", attrs, 4);
        NSLog(@"is success -> %d",isSuccess);
        //    console output:
        //    is success -> 1
    }
}

//为car的子类添加成员变量
- (void)addInstanceVariableForCar {
    Class cls = objc_allocateClassPair(Car.class, "CarSubClass", 0);    //创建Car类的子类
    BOOL isAddSuccess = class_addIvar(cls, "speed", sizeof(NSString *), log2(_Alignof(NSString *)), @encode(NSString));     //添加成员变量
    objc_registerClassPair(cls);

    if (isAddSuccess) {
        id accord = [[cls alloc] init];
        Ivar speed = class_getInstanceVariable(cls, "speed");
        object_setIvar(accord, speed, @"120");
        NSString *accordSpeed = object_getIvar(accord, speed);
        NSLog(@"accord speed -> %@",accordSpeed);
        
        //    console output:
        //    accord speed -> 120
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
