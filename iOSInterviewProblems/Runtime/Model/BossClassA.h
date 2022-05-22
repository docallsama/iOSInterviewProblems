//
//  BossClassA.h
//  iOSInterviewProblems
//
//  Created by oliver on 2022/5/21.
//  Copyright © 2022 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Test)

- (void)test;
+ (void)test1;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BossClassA : NSObject

- (void)testUserDetault; //!<10
- (void)syncMain; //!<11
- (NSString *)getString; //!<13

@property (nonatomic, copy) NSString *name;
- (void)print; //!<15

@end

NS_ASSUME_NONNULL_END
