//
//  Book.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/10/18.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)float price;
@property (nonatomic,strong)NSDate *publishTime;

- (int)pageCount;
- (void)setPageCount:(int)pageCount;

@end
