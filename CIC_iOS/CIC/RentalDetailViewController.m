//
//  RentalDetailViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 24..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "RentalDetailViewController.h"
#import "UIImage+Async.h"
#import "LKHttpRequest.h"
@interface RentalDetailViewController()<UIAlertViewDelegate>{
    BOOL isStartDate;
    BOOL isEndDate;
}
@property (nonatomic,strong) LKHttpRequest *request;
@property (weak, nonatomic) IBOutlet UIImageView *img_equip;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_equip_id;
@property (weak, nonatomic) IBOutlet UILabel *label_enable;
@property (weak, nonatomic) IBOutlet UILabel *label_rentaled;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;
@property (weak, nonatomic) IBOutlet UIButton *btn_end;
@property (nonatomic,strong) NSMutableDictionary *equipDic;
@end
@implementation RentalDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.request = [[LKHttpRequest alloc]init];
    [UIImage loadFromURL:[NSURL URLWithString:[self.equipDic valueForKey:@"equip_img"]] callback:^(UIImage *image) {
        self.img_equip.image = image;
    }];
    self.label_name.text = [self.equipDic valueForKey:@"name"];
    self.label_equip_id.text = [self.equipDic valueForKey:@"equip_id"];
    self.label_rentaled.text = Int2Str([[self.equipDic valueForKey:@"rental_count"] intValue]);
    self.label_enable.text = Int2Str([[self.equipDic valueForKey:@"total_count"]intValue]-[[self.equipDic valueForKey:@"rental_count"]intValue]);

}

- (IBAction)pushedDateBtn:(id)sender {
    [self showDatePickerView];
    if([sender isEqual:self.btn_start]){
        isStartDate = true;
        isEndDate = false;
    }
    else if([sender isEqual:self.btn_end]){
        isStartDate = false;
        isEndDate = true;
    }
}
- (void)setupUserData:(NSDictionary *)equip{
    self.equipDic = equip.mutableCopy;
    [self.equipDic setValue:sharedUserInfo(@"pkid") forKey:@"user_id"];
    [self.equipDic setValue:@(1) forKey:@"status"];//대여 신청
}
-(void)dateChanged:(id)sender{
    //날짜 변경시에 콜됨

}
- (void)datePickerDoneClick{
    NSLog(@"%@",[self getSelectedDate]);
    NSDate *birth = [self getSelectedDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    if(isStartDate==true){
        [self.btn_start setTitle:[dateFormatter stringFromDate:birth] forState:UIControlStateNormal];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        [self.equipDic setValue:[dateFormatter stringFromDate:birth] forKey:@"start_date"];
    }
    if(isEndDate==true){
        [self.btn_end setTitle:[dateFormatter stringFromDate:birth] forState:UIControlStateNormal];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        [self.equipDic setValue:[dateFormatter stringFromDate:birth] forKey:@"end_date"];
    }
    
    [self hideDatePickerView];
    isStartDate = false;
    isEndDate = false;
    
}
- (IBAction)pushedRequestRental:(id)sender {
    if(![self.equipDic valueForKey:@"start_date"]||![self.equipDic valueForKey:@"end_date"]){
        [self showAlertViewWithTitle:@"오류" description:@"대여일과 반납일을 선택해주세요"];
        return;
    }
    NSLog(@"%@",self.equipDic);
    [self.request postWithURL:kURL_RENTAL_BOOK withParams:self.equipDic compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"jsonDic : %@",jsonDic);
        if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]){
            [self showAlertViewWithTitle:@"대여신청완료" description:@""];
        }else{
            [self showAlertViewWithTitle:[[jsonDic objectForKey:@"data"] valueForKey:@"title"] description:[[jsonDic objectForKey:@"data"] valueForKey:@"message"]];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[alertView title]isEqualToString:@"오류"]){
        
    }else
        [self.navigationController popViewControllerAnimated:true];
}

@end
