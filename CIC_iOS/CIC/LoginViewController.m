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


    // Do any additional setup after loading the view, typically from a nib.
    self.request = [[LKHttpRequest alloc]init];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *VC = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    [self.navigationController pushViewController:VC animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushedLogin:(id)sender {
    if(self.field_id.text.length==0||self.field_pw.text.length==0){
        [self showAlertViewWithTitle:@"" description:@"입력값을 확인해주세요"];
        
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
