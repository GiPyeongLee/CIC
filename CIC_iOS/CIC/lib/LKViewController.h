//
//  LKViewController.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 6..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "FlatUIKit.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
@interface LKViewController : UIViewController{
    CGRect touchFieldRect;
    CGRect goalFrame;
}
- (void)showAlertViewWithTitle:(NSString *)title description:(NSString *)description;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@end
