//
//  DemoThread.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/2/2.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoThread : NSObject

+ (void)run4TaskNSThreadLock;

+ (void)run4TaskOperation;

+ (void)run4TaskGCD;

+ (BOOL)testDicEqual:(NSDictionary *)lDic with:(NSDictionary *)rDic;

@end

NS_ASSUME_NONNULL_END
