//
//  ViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LoginViewController.h"
#import "LKHttpRequest.h"

@interface LoginViewController ()
@property (nonatomic,strong) LKHttpRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *field_id;
@property (weak, nonatomic) IBOutlet UITextField *field_pw;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sidePanelController.allowLeftSwipe =false;
    [self.scrollView setContentSize:self.view.frame.size];
    // Do any additional setup after loading the view, typically from a nib.
    self.request = [[LKHttpRequest alloc]init];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]){
//        [self.navigationController pushViewController:VIEWCONTROLLER(@"MainViewController") animated:true];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushedLogin:(id)sender {
    if(self.field_id.text.length==0){
        [self showAlertViewWithTitle:@"" description:@"아이디를 확인해주세요"];
        
        return;
    }
    if(self.field_pw.text.length==0){
        [self showAlertViewWithTitle:@"" description:@"비밀번호를 확인해주세요"];
        
        return;
    }
    [self.request postWithURL:kURL_MEMBER_LOGIN withParams:@{@"user_id":self.field_id.text,@"user_pw":self.field_pw.text} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"jsonArray : %@",jsonDic);

        if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]){
            [[NSUserDefaults standardUserDefaults] setObject:[jsonDic objectForKey:@"data"] forKey:@"userInfo"];
            [self.navigationController pushViewController:VIEWCONTROLLER(@"MainViewController") animated:true];
        }else if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_FAIL]){
            [self showAlertViewWithTitle:[[jsonDic objectForKey:@"data"] valueForKey:@"title"] description:[[jsonDic objectForKey:@"data"] valueForKey:@"message"]];
        }

    }];
}
- (IBAction)pushedRegist:(id)sender {
    if([self.field_id isFirstResponder])
        [self.field_id resignFirstResponder];
    if([self.field_pw isFirstResponder])
        [self.field_pw resignFirstResponder];
    
    [self.navigationController pushViewController:VIEWCONTROLLER(@"RegistViewController") animated:true];
}



@end
