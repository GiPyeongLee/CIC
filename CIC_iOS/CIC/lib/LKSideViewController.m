//
//  LKSideViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKSideViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
@implementation LKSideViewController
- (void)viewDidLoad {
    UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"SideMenu";
    [label sizeToFit];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:label];

}
#pragma mark - Button Actions

- (void)_changeCenterPanelTapped:(id)sender {

//    self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
    
}


@end
