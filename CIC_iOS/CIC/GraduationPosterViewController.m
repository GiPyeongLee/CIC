//
//  GraduationPosterViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "GraduationPosterViewController.h"
#import "GraduationDetailCell.h"
#import "GraduationMiddleCell.h"
#import "GraduationBottomCell.h"
@interface GraduationPosterViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *dataDic;
@end
@implementation GraduationPosterViewController
@synthesize dataDic;
- (void)preloadData:(NSDictionary *)dic{
    self.dataDic = dic;
}

#pragma mark - UITableViewData,UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 138.f;
    }
    else if(indexPath.row==1){
        UIImage *coverImg = IMAGE([dataDic valueForKey:@"cover"]);

        return (coverImg.size.height*290.f/coverImg.size.width);
    }
    else if(indexPath.row==2){
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
        CGRect rect = [[self.dataDic valueForKey:@"description"] boundingRectWithSize:CGSizeMake(290, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        return rect.size.height+20;
    }else{
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        GraduationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraduationDetailCell"];
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
        cell.label_title.text = [self.dataDic valueForKey:@"title"];
        cell.label_type.text = [self.dataDic valueForKey:@"type"];
        return cell;
    }else if(indexPath.row==1){
        GraduationMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraduationMiddleCell"];
        cell.img_cover.image = IMAGE([dataDic valueForKey:@"cover"]);
        NSLog(@"%f %f",(cell.img_cover.image.size.height*290.f/cell.img_cover.image.size.width),cell.frame.size.height);
        [cell.img_cover setFrame:CGRectMake(15, 0, 290.f, cell.frame.size.height)];
        return cell;
    }else{
        GraduationBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraduationBottomCell"];
        cell.label_description.text = [dataDic valueForKey:@"description"];
        return cell;
    }
}
@end
