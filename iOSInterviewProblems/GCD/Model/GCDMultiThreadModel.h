//
//  GCDMultiThreadModel.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/7.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDMultiThreadModel : NSObject

@property (atomic, copy)NSString *modelName;
@property (nonatomic, retain)NSData *imgData;

- (void)setName:(NSString *)name;

@end
