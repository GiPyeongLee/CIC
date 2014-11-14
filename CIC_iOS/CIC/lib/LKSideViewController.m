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
#import "LKHttpRequest.h"
#import "Define.h"
#import "UIImage+Async.h"
@interface LKSideViewController() <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LKHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_id;
@property (nonatomic,strong) LKHttpRequest *request;


@end
@implementation LKSideViewController
- (void)viewDidLoad {
    
    if(!self.request){
        self.request = [[LKHttpRequest alloc]init];
        self.request.delegate =self;
    }

    self.img_profile.layer.cornerRadius = 25.0f;
    self.img_profile.layer.masksToBounds = true;
    [self.label_name setText:sharedUserInfo(@"name")];
    [self.label_id setText:sharedUserInfo(@"pkid")];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)refreshInfo{
    [UIImage loadFromURL:[NSURL URLWithString:sharedUserInfo(@"profile_img")] callback:^(UIImage *image) {

            self.img_profile.image = image;
    }];
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
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"프로필 사진 변경" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"앨범에서 사진선택" otherButtonTitles:@"사진촬영",@"삭제", nil];
    [actionSheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==3){
        //취소
    }
    else if (buttonIndex==0){
        // 앨범에서 사진선택
        [self startMediaBrowserFromViewController: self
                                    usingDelegate: self];
    }
    else if(buttonIndex==1){
        // 사진촬영
        [self startCameraFromViewController:self usingDelegate:self];
    }
    else if(buttonIndex==2){
        // 사진삭제
        [self.request uploadDataWithURL:kURL_MEMBER_UPLOAD_PROFILE withParams:nil withImage:UIImageJPEGRepresentation(IMAGE(@"noimage"), 1.0)];
    }
    
}

#pragma mark - Photo Library

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = true;

    
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:true completion:^{
        
    }];
    return YES;
}

- (BOOL) startCameraFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = true;
    
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:true completion:^{
        
    }];
    return YES;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block UIImage *chosenImage = [UIImage imageWithImage:info[UIImagePickerControllerEditedImage] scaledToSize:CGSizeMake(150, 150)];
    

    [picker dismissViewControllerAnimated:YES completion:^{
        [self.request uploadDataWithURL:kURL_MEMBER_UPLOAD_PROFILE withParams:nil withImage:UIImageJPEGRepresentation(chosenImage, 1.0)];
    }];
    
}



- (void)finishUploadData{
    NSLog(@"%s",__FUNCTION__);
    [UIImage loadFromURL:[NSURL URLWithString:sharedUserInfo(@"profile_img")] callback:^(UIImage *image) {
        self.img_profile.image = image;
    }];
}
@end
