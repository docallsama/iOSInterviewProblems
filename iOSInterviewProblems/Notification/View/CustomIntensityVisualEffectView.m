//
//  CustomIntensityVisualEffectView.m
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/8/27.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import "CustomIntensityVisualEffectView.h"

@interface CustomIntensityVisualEffectView ()

@property (nonatomic, strong) UIViewPropertyAnimator *animator;

@end

@implementation CustomIntensityVisualEffectView

- (instancetype)initWithEffect:(UIVisualEffect *)effect andIntensity:(CGFloat)intensity
{
    self = [super initWithEffect:effect];
    if(self){
        _animator = [[UIViewPropertyAnimator alloc] initWithDuration:1 curve:UIViewAnimationCurveLinear animations:^{
            self.effect = effect;
        }];
        _animator.fractionComplete = intensity;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
