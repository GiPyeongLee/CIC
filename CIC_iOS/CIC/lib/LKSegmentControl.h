//
//  LKSegmentControl.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LKSegmentDelegate
- (void)selectedSegment:(id)sender;
@end
@interface LKSegmentControl : UIView
@property (nonatomic,assign) IBOutlet id <LKSegmentDelegate>delegate;
-(void)setSelectedIndex:(NSInteger)index;
@end
