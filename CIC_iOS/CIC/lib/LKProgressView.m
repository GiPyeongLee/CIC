//
//  LKProgressView.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 13..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKProgressView.h"
#import "UIColor+FlatUI.h"
@interface LKProgressView ()
@end
@implementation LKProgressView
@synthesize delegate;
- (id)init{
    self = [super init];
    if(self){
        float width = [[[UIApplication sharedApplication]keyWindow]bounds].size.width;
        float height = [[[UIApplication sharedApplication]keyWindow]bounds].size.height;
        NSLog(@"%s %f %f",__FUNCTION__,width,height);
        float viewHeight = 100.0f;
        float progressHeight = 20.0f;
        self.frame = CGRectMake(0, height, width, viewHeight);
        self.backgroundColor = [UIColor midnightBlueColor];
        self.progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        [self.progress setFrame:CGRectMake(0, self.frame.size.height-progressHeight, self.frame.size.width, progressHeight)];
        [self.progress setProgressTintColor:[UIColor carrotColor]];

        self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width*2/3, viewHeight-progressHeight)];
        [self.progressLabel setTextColor:[UIColor whiteColor]];
        [self.progressLabel setTextAlignment:NSTextAlignmentCenter];
        [self.progressLabel setFont:[UIFont systemFontOfSize:(viewHeight-progressHeight)/2]];

        
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(width*2/3, 0, width-width*2/3, viewHeight-progressHeight)];
        [cancelButton setTitle:@"X" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(pushedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.progress];
        [self addSubview:self.progressLabel];
        [self addSubview: cancelButton];
        
    }
    return self;
}
- (void)showProgressView{
    NSLog(@"%s",__FUNCTION__);
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    CGRect newFrame = self.frame;
    newFrame.origin.y -=newFrame.size.height;
    
    [UIView animateWithDuration:1.0f delay:0.f usingSpringWithDamping:15.0f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {

    }];

}

- (void)hideProgressView{
    CGRect newFrame = self.frame;
    newFrame.origin.y +=newFrame.size.height;

    [UIView animateWithDuration:1.0f delay:1.0f usingSpringWithDamping:15.0f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
- (void)pushedCancelBtn:(UIButton *)sender{
    [delegate cancelRequest];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
