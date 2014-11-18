//
//  LKLoadingView.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 19..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKLoadingView.h"
#define kFadeDuration 0.75f
@implementation LKLoadingView
+(void)showInView:(UIView *)view{
    float duration = 1.f;
    float rotations = 1.f;
    CGRect rect = view.frame;
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width,rect.size.height)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_indicator"]];
    [imageView setFrame:CGRectMake((rect.size.width-50)/2,(rect.size.height-50)/2, 50, 50)];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 999;
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [loadingView addSubview:imageView];
    [loadingView setTag:374];
    [loadingView setAlpha:0.0f];
    [view addSubview:loadingView];
    [UIView animateWithDuration:kFadeDuration animations:^{
        [loadingView setAlpha:1.0f];
    }];
}
+(void)hideInView:(UIView *)view{
    [UIView animateWithDuration:kFadeDuration animations:^{
        [[view viewWithTag:374] setAlpha:0.f];
    } completion:^(BOOL finished) {
        [[view viewWithTag:374]removeFromSuperview];
    }];

}
@end
