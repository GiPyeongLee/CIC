//
//  RegistViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "RegistViewController.h"
#import "LKHttpRequest.h"
@interface RegistViewController() <UIActionSheetDelegate>
{
    
}
@property (nonatomic,strong) LKHttpRequest *request;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet UIButton *btn_birthday;
@property (nonatomic,strong) NSMutableDictionary *userDic;
@property (weak, nonatomic) IBOutlet UITextField *field_name;
@property (weak, nonatomic) IBOutlet UITextField *field_id;
@property (weak, nonatomic) IBOutlet UITextField *field_pwd;
@property (weak, nonatomic) IBOutlet UITextField *field_pwd_chk;
@property (weak, nonatomic) IBOutlet UITextField *field_email;
@property (weak, nonatomic) IBOutlet UITextField *field_phone;



@end
@implementation RegistViewController
- (void)viewDidLoad{
    self.request = [[LKHttpRequest alloc]init];
    [self.scrollView setContentSize:self.scrollView.frame.size];
    self.userDic = [[NSMutableDictionary alloc]init];
}
- (IBAction)pushedTypeBtn:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"구분" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"재학생" otherButtonTitles:@"휴학생",@"졸업생",@"교수",@"교직원",@"기타", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"취소"]){
        [self.btn_select setBackgroundImage:IMAGE(@"btn_filter_classname") forState:UIControlStateNormal];
        [self.btn_select setTitle:@"" forState:UIControlStateNormal];
        [self.btn_select setTag:10];
    }else{
        [self.btn_select setBackgroundImage:IMAGE(@"btn_select_job") forState:UIControlStateNormal];
        [self.btn_select setTitle:[actionSheet buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
        [self.btn_select setTag:buttonIndex];
    }
}
- (IBAction)pushedBirthBtn:(id)sender {
    [self showDatePickerView];
}

-(void)dateChanged:(id)sender{
    //날짜 변경시에 콜됨
}
- (void)datePickerDoneClick{
    NSLog(@"%@",[self getSelectedDate]);
    NSDate *birth = [self getSelectedDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY년 MM월 dd일"];
    [self.btn_birthday setTitle:[dateFormatter stringFromDate:birth] forState:UIControlStateNormal];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    [self.userDic setValue:[dateFormatter stringFromDate:birth] forKey:@"birth"];
    [self hideDatePickerView];
    
}

- (IBAction)pushedRegistBtn:(id)sender {
    /*
     $kUSER = $_GET['user_id'];#
     $kPASS = $_GET['user_pw'];#
     $kBIRTH = $_GET['user_birth'];#
     $kNAME = $_GET['user_name'];#
     $kMOBILE = $_GET['user_mobile'];#
     $kTYPE = $_GET['user_type'];#
     $kEMAIL = $_GET['user_email'];#
     */
    if([self.field_name.text rangeOfString:@"^[가-힣]{2,5}$" options:NSRegularExpressionSearch].location == NSNotFound){
        [self showAlertViewWithTitle:@"" description:@"이름을 확인해주세요."];
        return;
    }
   
    if(self.btn_select.tag==10){
        [self showAlertViewWithTitle:@"" description:@"구분을 선택해주세요."];
        return;
    }
    if(self.btn_select.tag==0){
        if(self.field_id.text.length<4){
            [self showAlertViewWithTitle:@"" description:@"학번을 확인해주세요."];
            return;
        }
    }else{
        if(self.field_id.text.length<4){
            [self showAlertViewWithTitle:@"" description:@"최소 네글자 이상 입력해주세요."];
            return;
        }
    }
    if(self.field_pwd.text.length<4){
        [self showAlertViewWithTitle:@"" description:@"비밀번호는 4글자 이상입력해주세요."];
        return;
    }
    if(![self.field_pwd.text isEqualToString:self.field_pwd_chk.text]){
        [self showAlertViewWithTitle:@"" description:@"비밀번호 확인을 다시해주세요."];
        return;
    }
    
    if([self.field_email.text rangeOfString:@"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$" options:NSRegularExpressionSearch].location == NSNotFound){
        [self showAlertViewWithTitle:@"" description:@"이메일주소를 확인해주세요."];
        return;
    }

    if([self.field_phone.text rangeOfString:@"^\\d{3}-\\d{3,4}-\\d{4}$" options:NSRegularExpressionSearch].location == NSNotFound){
        [self showAlertViewWithTitle:@"" description:@"핸드폰번호를 확인해주세요."];
        return;
    }
    if([self.btn_birthday.titleLabel.text isEqualToString:@"생년월일 (1989년 09월 07일)"]){
        [self showAlertViewWithTitle:@"" description:@"생년월일을 선택해주세요."];
        return;
    }
    
    [self.request postWithURL:kURL_MEMBER_JOIN withParams:@{@"user_name":self.field_name.text,@"user_id":self.field_id.text,@"user_pw":self.field_pwd.text,@"user_birth":[self.userDic valueForKey:@"birth"],@"user_mobile":self.field_phone.text,@"user_type":@(self.btn_select.tag),@"user_email":self.field_email} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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


@end
