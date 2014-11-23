//
//  RentalViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "RentalViewController.h"
#import "LKSegmentControl.h"
@interface RentalViewController()<LKSegmentDelegate>{
    NSInteger selectedIndex;
}
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@end
@implementation RentalViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.segmentCtrl setSelectedIndex:selectedIndex];
}
- (void)setupSelectedSegement:(NSInteger)index withData:(NSDictionary *)data{
    selectedIndex = index;
}
#define mark - LKSegmentDelegate

- (void)selectedSegment:(id)sender{
    selectedIndex = [sender tag];
    [self.segmentCtrl setSelectedIndex:selectedIndex];
}

@end
