//
//  MemberCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *profile_img;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_email;
@property (weak, nonatomic) IBOutlet UILabel *lable_room;
@property (weak, nonatomic) IBOutlet UILabel *label_school;
@property (weak, nonatomic) IBOutlet UILabel *label_major;

@end
