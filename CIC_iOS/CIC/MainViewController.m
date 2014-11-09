//
//  MainViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController()
@end
@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)pushedSideMenu:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:true];
}

@end
