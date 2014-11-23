//
//  GraduationDetailViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "GraduationDetailViewController.h"
#import "GraduationDetailCell.h"
#import "Define.h"

@interface GraduationDetailViewController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end
@implementation GraduationDetailViewController
- (void)viewDidLoad{
    self.navTitle.text = self.titleString;
}
- (void)preloadData:(NSArray *)dataArray withTitle:(NSString *)title{
    self.titleString = title;
    
    self.dataArray = dataArray.mutableCopy;
}
#pragma mark - UITableViewData,Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GraduationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraduationDetailCell"];
    NSDictionary *dataDic = [self.dataArray objectAtIndex:indexPath.row];
    cell.label_title.text = [dataDic valueForKey:@"title"];
    cell.label_type.text =  [dataDic valueForKey:@"type"];
    cell.img_profile_1.layer.cornerRadius = 20.f;
    cell.img_profile_2.layer.cornerRadius = 20.f;
    cell.img_profile_3.layer.cornerRadius = 20.f;
    cell.img_profile_1.layer.masksToBounds = true;
    cell.img_profile_2.layer.masksToBounds = true;
    cell.img_profile_3.layer.masksToBounds = true;
    if(indexPath.row==0){
        cell.img_type.image = IMAGE(@"img_badge_1st");
    }else if(indexPath.row==1){
        cell.img_type.image = IMAGE(@"img_badge_2nd");
    }else if(indexPath.row==2){
        cell.img_type.image = IMAGE(@"img_badge_3rd");
    }
    if([[dataDic objectForKey:@"members"]count]==3){
       cell.label_name_profile_1.text = [[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"name"];
       cell.label_name_profile_2.text = [[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"name"];
       cell.label_name_profile_3.text = [[[dataDic objectForKey:@"members"]objectAtIndex:2] valueForKey:@"name"];
        cell.label_pkid_profile_1.text = [[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"pkid"];
        cell.label_pkid_profile_2.text = [[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"pkid"];
        cell.label_pkid_profile_3.text = [[[dataDic objectForKey:@"members"]objectAtIndex:2] valueForKey:@"pkid"];
        cell.img_profile_1.image = IMAGE([[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"profile_img"]);
        cell.img_profile_2.image = IMAGE([[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"profile_img"]);
        cell.img_profile_3.image = IMAGE([[[dataDic objectForKey:@"members"]objectAtIndex:2] valueForKey:@"profile_img"]);
        
    }else if([[dataDic objectForKey:@"members"]count]==2){
        cell.label_name_profile_1.text = [[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"name"];
        cell.label_name_profile_2.text = [[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"name"];
        cell.label_name_profile_3.text = @"";
        cell.label_pkid_profile_1.text = [[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"pkid"];
        cell.label_pkid_profile_2.text = [[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"pkid"];
        cell.label_pkid_profile_3.text = @"";
        cell.img_profile_1.image = IMAGE([[[dataDic objectForKey:@"members"]objectAtIndex:0] valueForKey:@"profile_img"]);
        cell.img_profile_2.image = IMAGE([[[dataDic objectForKey:@"members"]objectAtIndex:1] valueForKey:@"profile_img"]);
        cell.img_profile_3.image = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
