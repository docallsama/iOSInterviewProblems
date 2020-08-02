//
//  PerformedObject.h
//  iOSInterviewProblems
//
//  Created by oliver on 2020/8/2.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^PerformCheck)(NSString *name);

@interface PerformedObject : NSObject

@property (nonatomic, copy) PerformCheck block;

- (void)testNetRequest;

@end
