//
//  RunloopViewController.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/14.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunloopThread.h"

@interface RunloopViewController : UIViewController

@property (nonatomic, strong) NSTimer *runloopTimer;
@property (nonatomic, strong) NSThread *socketThread;
@property (nonatomic, strong) RunloopThread *continueThread; //!<保活线程

@end
