//
//  RentalViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "RentalViewController.h"
#import "RentalDetailViewController.h"
#import "LKSegmentControl.h"
#import "RentalCell.h"
#import "RentalStatusCell.h"
#import "RentalAdminCell.h"
#import "UIImage+Async.h"
#import "Define.h"
#import "LKHttpRequest.h"
@interface RentalViewController()<UITableViewDataSource,UITableViewDelegate, LKSegmentDelegate>{
    NSInteger selectedIndex;
    BOOL isEditing;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) LKHttpRequest *request;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@end
@implementation RentalViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    isEditing =false;
    [self.segmentCtrl setSelectedIndex:selectedIndex];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.request)
        self.request = [[LKHttpRequest alloc]init];
    
    [self.request postWithURL:kURL_RENTAL_LIST withParams:@{@"status":@(selectedIndex),@"user_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        self.dataArray = [[jsonDic objectForKey:@"data"]mutableCopy];
    }];
    
}
- (void)setupSelectedSegement:(NSInteger)index withData:(NSDictionary *)data{
    selectedIndex = index;
    if(index==0)
        self.btn_edit.alpha=0.f;
    
    self.dataArray = [[data objectForKey:@"data"]mutableCopy];

}
#define mark - LKSegmentDelegate

- (void)selectedSegment:(id)sender{
    isEditing = false;
    
    selectedIndex = [sender tag];
    if(selectedIndex==0)
        self.btn_edit.alpha=0.f;
    else
        self.btn_edit.alpha=1.f;
    
    [self.segmentCtrl setSelectedIndex:selectedIndex];

    [self.request postWithURL:kURL_RENTAL_LIST withParams:@{@"status":@(selectedIndex),@"user_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        self.dataArray = [[jsonDic objectForKey:@"data"]mutableCopy];
        [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

#pragma mark - UITableViewData,Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex==0||selectedIndex==3){
        RentalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentalCell"];
        NSDictionary *equipDic = [self.dataArray objectAtIndex:indexPath.row];
        [UIImage loadFromURL:[NSURL URLWithString:[equipDic valueForKey:@"equip_img"]] callback:^(UIImage *image) {
            cell.img_equipment.image = image;
        }];
        cell.label_name.text = [equipDic valueForKey:@"name"];
        cell.label_pkid.text = [equipDic valueForKey:@"equip_id"];
        cell.label_rentaled.text = Int2Str([[equipDic valueForKey:@"rental_count"] intValue]);
        cell.label_enable.text = Int2Str([[equipDic valueForKey:@"total_count"]intValue]-[[equipDic valueForKey:@"rental_count"]intValue]);
        if([cell.label_enable.text intValue]==0){
            [cell.img_disable setAlpha:0.2f];
            [cell setUserInteractionEnabled:false];
        }
        else{
            [cell.img_disable setAlpha:0.f];
            [cell setUserInteractionEnabled:true];
        }
        return cell;
    }
    else if(selectedIndex==1||selectedIndex==2){
        RentalStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentalStatusCell"];
        NSDictionary *equipDic = [self.dataArray objectAtIndex:indexPath.row];
        [UIImage loadFromURL:[NSURL URLWithString:[equipDic valueForKey:@"equip_img"]] callback:^(UIImage *image) {
            cell.img_equipment.image = image;
        }];
        cell.label_name.text = [equipDic valueForKey:@"name"];
        cell.label_pkid.text = [equipDic valueForKey:@"equip_id"];
        cell.btn_status.tag = indexPath.row;
        if(!isEditing){
            [cell.btn_status addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];

            if([[equipDic valueForKey:@"status"]intValue]==1)
            {
                [cell.btn_status setImage:IMAGE(@"asset_btn_request_ing") forState:UIControlStateNormal];
            }
            else if([[equipDic valueForKey:@"status"]intValue]==2)
            {
                [cell.btn_status setImage:nil forState:UIControlStateNormal];
            }
            else if([[equipDic valueForKey:@"status"]intValue]==4)
            {
                [cell.btn_status setImage:IMAGE(@"asset_btn_return_ing") forState:UIControlStateNormal];
            }
        }else{
            [cell.btn_status addTarget:self action:@selector(pushedStatusEditBtn:) forControlEvents:UIControlEventTouchUpInside];

            if([[equipDic valueForKey:@"status"]intValue]==1)
            {
                [cell.btn_status setImage:IMAGE(@"asset_btn_request_cancel") forState:UIControlStateNormal];
            }
            else if([[equipDic valueForKey:@"status"]intValue]==2)
            {
                [cell.btn_status setImage:IMAGE(@"btn_request_return") forState:UIControlStateNormal];
            }
            else if([[equipDic valueForKey:@"status"]intValue]==4)
            {
                [cell.btn_status setImage:IMAGE(@"asset_btn_return_cancel") forState:UIControlStateNormal];
            }
        }
        return cell;
    }
//    else if(selectedIndex==2){
//        RentalAdminCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"RentalAdminCell"];
//        NSDictionary *equipDic = [self.dataArray objectAtIndex:indexPath.row];
//        [UIImage loadFromURL:[NSURL URLWithString:[equipDic valueForKey:@"equip_img"]] callback:^(UIImage *image) {
//            cell.img_equipment.image = image;
//        }];
//        cell.label_name.text = [equipDic valueForKey:@"name"];
//        cell.label_pkid.text = [equipDic valueForKey:@"equip_id"];
//        return cell;
//    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RentalDetailViewController *VC = VIEWCONTROLLER(@"RentalDetailViewController");
    [VC setupUserData:[self.dataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:VC animated:true];
}

- (IBAction)pushedEditBtn:(id)sender {
    isEditing=!isEditing;
    [self.m_tableView reloadData];
}

- (void)pushedStatusEditBtn:(id)sender{
    NSMutableDictionary *dic = [[self.dataArray objectAtIndex:[sender tag]]mutableCopy];
    if([[dic valueForKey:@"status"]intValue]==1)
    { // 신청취소
        [dic setObject:@(0) forKey:@"newStatus"];
    }
    else if([[dic valueForKey:@"status"]intValue]==2)
    { // 반납신청
        [dic setObject:@(4) forKey:@"newStatus"];
    }
    else if([[dic valueForKey:@"status"]intValue]==4)
    { // 반납취소
        [dic setObject:@(2) forKey:@"newStatus"];
    }
    [dic setValue:sharedUserInfo(@"pkid") forKey:@"user_id"];

    NSLog(@"%@",dic);
    [self.request postWithURL:kURL_RENTAL_BOOK withParams:dic compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]){

            [self.dataArray removeObjectAtIndex:[sender tag]];
            [self.m_tableView reloadData];
        }else if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_FAIL]){
            [self showAlertViewWithTitle:[[jsonDic objectForKey:@"data"] valueForKey:@"title"] description:[[jsonDic objectForKey:@"data"] valueForKey:@"message"]];
        }else{
            [self.dataArray removeObjectAtIndex:[sender tag]];
            [self.m_tableView reloadData];
        }
    }];
    
}

@end
