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
#import "Student.h"

@interface RuntimeViewController ()

@property (nonatomic, assign)Car *deBenz;

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInstanceVariable];
//    [self getSuperClassInstanceVariable];
//    [self getClassAllIvar];
//    [self getClassProperty];
//    [self addPropertyForCar];
//    [self addInstanceVariableForCar];
//    
//    [self addMethodForCar];
//    [self getMethodsOfPerson];
//    [self replaceMethodOfPerson];
//    [self replaceMethodOfPersonWithExistMethod];
    
//    [self personWithUnkownMethod];
}

#pragma mark - 属性相关操作

//获取类的成员变量
- (void)getInstanceVariable {
    Son *son = [[Son alloc] init];
    [son doWork];   //father doing work
    [son configWhoIam];
    
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

#pragma mark - 方法相关操作

//向car类添加方法
- (void)addMethodForCar {
    Class carClass = objc_getClass("Car");
    BOOL isSuccess = class_addMethod(carClass, @selector(reverse), class_getMethodImplementation([self class], @selector(controllerReverse)), "v@:");
    
    if (isSuccess) {
        Car *fit = [[Car alloc] init];
        [fit performSelector:@selector(reverse) withObject:nil];
    }
}

//添加的方法实现
- (void)controllerReverse {
    NSLog(@"car reverse");
}

//获取Person类的方法
- (void)getMethodsOfPerson {
    //获取实体方法
    unsigned int outcountMethod;
    id PersonClass = objc_getClass("Person");
    Method *methods = class_copyMethodList(PersonClass, &outcountMethod);
    for (int i = 0; i < outcountMethod; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        IMP implement = method_getImplementation(method);
        const char *selName = sel_getName(methodSEL);
        
        if (methodSEL) {
            NSLog(@"selector name -> %s", selName);
        }
    }
    free(methods);
    
    // console output:
    // selector name -> fakeRun
    // selector name -> normalRun  iOSInterviewProblems`-[Person(MethodRun) normalRun] at Person+MethodRun.m:17
    // selector name -> normalRun  iOSInterviewProblems`-[Person normalRun] at Person.m:40
}

//替换Person类的方法
- (void)replaceMethodOfPerson {
    Class PersonClass = objc_getClass("Person");
    IMP replaceIMP = class_getMethodImplementation([self class], @selector(playFootBall:));
    class_replaceMethod(PersonClass, @selector(innerMethod), replaceIMP, "v@:");

    id person = [[PersonClass alloc] init];
    [person performSelector:@selector(innerMethod) withObject:@"allen"];

    // console output:
    // allen is playing football
}

- (void)playFootBall:(NSString *)name {
    NSLog(@"%@ is playing football",name);
}

//使用已有方法替换方法
- (void)replaceMethodOfPersonWithExistMethod {
    Class PersonClass = objc_getClass("Person");
    Method originalMethod = class_getInstanceMethod(PersonClass, @selector(originalMethodRun));
    Method swizzledMethod = class_getInstanceMethod(PersonClass, @selector(swizzledMethodRun));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    id person = [[PersonClass alloc] init];
    [person performSelector:@selector(originalMethodRun) withObject:nil];
    
    // console output:
    // perform swizzled method run
    
    Student *student = [[Student alloc] init];
    [student performSelector:@selector(originalMethodRun) withObject:nil];
    // console output:
    // perform swizzled method run
    //替换了方法之后，继承的类再调用方法，还是访问父类的方法实现，只是替换了方法列表中的方法实现
}

- (void)personWithUnkownMethod {
    self.deBenz = [[Car alloc] init];
//    [car performSelector:@selector(run) withObject:nil];
    [self.deBenz run];
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
