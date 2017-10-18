//
//  AFormClass.m
//  TestRewriteClass
//
//  Created by 谢艺欣 on 2017/9/25.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "BFormClass.h"

//在使用使用相同interface时候会直接造成 duplicate symbol

/*
@interface AFormClass : NSObject


@end

@implementation AFormClass

- (void)testBaseMethod {
    NSString *tempString = [NSString stringWithFormat:@""];
    tempString = @"1";
}

@end

*/
 
@implementation BFormClass

- (void)testBaseMethod {
    NSString *tempString = [NSString stringWithFormat:@""];
    tempString = @"1";
}

@end
