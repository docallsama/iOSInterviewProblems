//
//  TestGCDAsyncModel.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/20.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestGCDAsyncModel : NSObject

- (void)sendingAsyncConnect:(void (^)(NSString *testName))checkBlock;

@end
