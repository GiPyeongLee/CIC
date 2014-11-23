//
//  GraduationDetailCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraduationDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_type;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_type;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile_1;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile_2;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile_3;
@property (weak, nonatomic) IBOutlet UILabel *label_name_profile_1;
@property (weak, nonatomic) IBOutlet UILabel *label_pkid_profile_1;
@property (weak, nonatomic) IBOutlet UILabel *label_name_profile_2;
@property (weak, nonatomic) IBOutlet UILabel *label_pkid_profile_2;
@property (weak, nonatomic) IBOutlet UILabel *label_name_profile_3;
@property (weak, nonatomic) IBOutlet UILabel *label_pkid_profile_3;

@end
