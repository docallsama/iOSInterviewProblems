//
//  TestLayoutView.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/9/25.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "TestLayoutView.h"

@implementation TestLayoutView

#pragma mark - 自定义view复写的方法

//复写initWithFrame方法创建来自定义view
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

#pragma mark - 在不同分辨率屏幕上绘制1px线

- (void)drawOnePixelLine {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSLog(@"scale -> %f",scale);
    CGFloat lineHeight = 1 / scale;
    if (scale == 3) {
        lineHeight = lineHeight * 1.15;
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, lineHeight)];
    line.backgroundColor = [UIColor greenColor];
    [self addSubview:line];
}

#pragma mark - 触发 layoutSubviews 方法

//触发1
- (void)changeViewLayout {
//    [self setNeedsLayout];
}

//触发2
- (void)changeViewSize {
//    CGRect frame = self.frame;
//    frame.size = CGSizeMake(100, 100);
//    self.frame = frame;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutsubviews hit -> ");
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
