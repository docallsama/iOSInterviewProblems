//
//  HitTestView.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2017/12/19.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "HitTestView.h"

@implementation HitTestView

//等同于UIViewcontroller 的 viewdiddisappear
- (void)didMoveToSuperview;
{
    [super didMoveToSuperview];
    
    if (!self.superview) {
        NSLog(@"remove from superview");
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.clipsToBounds) {
        return nil;
    }
    if (self.hidden) {
        return nil;
    }
    if (self.alpha == 0) {
        return nil;
    }
    for (UIView *subview in self.subviews.reverseObjectEnumerator) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        UIView *result = [subview hitTest:subPoint withEvent:event];
        if (result) {
            return result;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
