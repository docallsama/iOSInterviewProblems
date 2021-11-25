//
//  ParentPerson.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/11/18.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import "ParentPerson.h"

@interface ParentPerson ()<NSCopying>

@end

@implementation ParentPerson

- (id)copyWithZone:(NSZone *)zone
{
    ParentPerson *cloneObject = [[ParentPerson alloc] init];
    cloneObject.name = self.name;
    cloneObject.age = self.age;
    return cloneObject;
    
//    id copy = [[self class] allocWithZone:zone];
//
//        if (copy) {
//            // Copy NSObject subclasses
//            [copy setName:[self.name copy]];
//            [copy setAge:[self.age copy]];
//        }
//
//    return copy;
    
//    return  self;
}

@end
