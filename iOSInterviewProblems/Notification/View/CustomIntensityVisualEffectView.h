//
//  CustomIntensityVisualEffectView.h
//  iOSInterviewProblems
//
//  Created by 谢艺欣 on 2020/8/27.
//  Copyright © 2020 谢艺欣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomIntensityVisualEffectView : UIVisualEffectView

- (instancetype)initWithEffect:(UIVisualEffect *)effect andIntensity:(CGFloat)intensity;

@end

NS_ASSUME_NONNULL_END
