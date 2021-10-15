//
//  AnimationSubClassView.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2021/10/14.
//  Copyright © 2021 谢艺欣. All rights reserved.
//

#import "AnimationSubClassView.h"

@implementation AnimationSubClassView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect presentingRect = self.frame;
    if (self.layer.presentationLayer) {//有动画的时候，才有值
        presentingRect = self.layer.presentationLayer.frame;
    }
    CGPoint superPoint = [self convertPoint:point toView:self.superview];
    BOOL isInside = CGRectContainsPoint(presentingRect, superPoint);//判断点击点是否显示层内
    NSLog(@"is inside -> %d",isInside);
    return isInside;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
