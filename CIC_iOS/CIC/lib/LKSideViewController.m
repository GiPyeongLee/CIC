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
#import "Define.h"
@interface LKSideViewController()
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_id;


@end
@implementation LKSideViewController
- (void)viewDidLoad {
    self.img_profile.layer.cornerRadius = 25.0f;
    self.img_profile.layer.masksToBounds = true;
    [self.label_name setText:sharedUserInfo(@"name")];
    [self.label_id setText:sharedUserInfo(@"pkid")];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
    
}
#pragma mark - Button Actions

- (void)_changeCenterPanelTapped:(id)sender {
    
}
// CIC 인사말 및 안내
- (IBAction)pushedIntroBtn:(id)sender {
}
// Board 게시판
- (IBAction)pushedBoardBtn:(id)sender {
}
// 졸업프로젝트
- (IBAction)pushedGraduateBtn:(id)sender {
}
// 사진
- (IBAction)pushedPhotoBtn:(id)sender {
}

// 상담
- (IBAction)pushedCounselBtn:(id)sender {
}
- (IBAction)pushedSettingBtn:(id)sender {
}
- (IBAction)pushedImageBtn:(id)sender {

}



@end
