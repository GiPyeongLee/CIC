//
//  LKProgressView.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 13..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LKProgressDelegate
@optional
- (void)cancelRequest;
@end
@interface LKProgressView : UIView
@property (nonatomic,assign) id<LKProgressDelegate>delegate;
@property (nonatomic,strong) UIProgressView *progress;
@property (nonatomic,strong) UILabel *progressLabel;

// Here is ProgressView's Methods
- (id)init;
- (void)hideProgressView;
- (void)showProgressView;
@end