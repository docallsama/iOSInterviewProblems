//
//  GCDViewController.h
//  iOSInterviewProblems
//
//  Created by oliver on 2017/11/9.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDViewController : UIViewController

@property (nonatomic, strong) dispatch_source_t timerSource;
@property (nonatomic, assign) int timerCountDown;

@end
