//
//  ViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "ViewController.h"
#import "LKHttpRequest.h"

@interface ViewController ()
@property (nonatomic,strong) LKHttpRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *field_id;
@property (weak, nonatomic) IBOutlet UITextField *field_pw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.request = [[LKHttpRequest alloc]init];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushedLogin:(id)sender {
    if(self.field_id.text.length==0||self.field_pw.text.length==0){
        FUIAlertView *alertView = [[FUIAlertView alloc]initWithTitle:@"" message:@"입력값을 확인해주세요." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alertView.backgroundOverlay.backgroundColor = [UIColor clearColor];
        alertView.titleLabel.textColor = [UIColor cloudsColor];
        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alertView.messageLabel.textColor = [UIColor cloudsColor];
        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
        alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
        alertView.defaultButtonColor = [UIColor cloudsColor];
        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alertView.defaultButtonTitleColor = [UIColor midnightBlueColor];
        alertView.alertContainer.layer.cornerRadius = 14.0f;
        [alertView show];
        
        return;
    }
    [self.request postWithURL:kURL_MEMBER_LOGIN withParams:@{@"user_id":self.field_id.text,@"user_pw":self.field_pw.text} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"jsonArray : %@",jsonDic);

    }];
}
- (IBAction)pushedRegist:(id)sender {
}

@end
