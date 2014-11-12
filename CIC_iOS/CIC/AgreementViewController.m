//
//  AgreementViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 12..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "AgreementViewController.h"
#import "AgreementContentsViewController.h"
@interface AgreementViewController()
{
    BOOL isFirstAgree;
    BOOL isSecondAgree;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_firstAgree;
@property (weak, nonatomic) IBOutlet UIButton *btn_secondAgree;
@end
@implementation AgreementViewController

- (IBAction)pushedPrivacyBtn:(id)sender {
    [sender isSelected]==true?[(UIButton *)sender setSelected:false]:[(UIButton *)sender setSelected:true];
    isFirstAgree = [sender isSelected];
}
- (IBAction)pushedThirdAgreeBtn:(id)sender {
     [sender isSelected]==true?[(UIButton *)sender setSelected:false]:[(UIButton *)sender setSelected:true];
    isSecondAgree = [sender isSelected];
}
- (IBAction)pushedAllAgreeBtn:(id)sender {
    [self.btn_firstAgree setSelected:true];
    [self.btn_secondAgree setSelected:true];
    isFirstAgree = true;
    isSecondAgree = true;
}
- (IBAction)pushedNextBtn:(id)sender {
    if(isFirstAgree&&isSecondAgree){
        [self.navigationController pushViewController:VIEWCONTROLLER(@"RegistViewController") animated:true];
    }else{
        [self showAlertViewWithTitle:@"" description:@"이용약관에 동의해주세요"];
    }
}
- (IBAction)firstAgreementBtn:(id)sender {
    AgreementContentsViewController *VC = VIEWCONTROLLER(@"AgreementContentsViewController");
    [VC initWithType:0];
    [self.navigationController pushViewController:VC animated:true];}
- (IBAction)secondAgreementBtn:(id)sender {
    AgreementContentsViewController *VC = VIEWCONTROLLER(@"AgreementContentsViewController");
    [VC initWithType:1];
    [self.navigationController pushViewController:VC animated:true];
}

@end
