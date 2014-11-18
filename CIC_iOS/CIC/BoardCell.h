//
//  BoardCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 18..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_description;
@property (weak, nonatomic) IBOutlet UIImageView *image_profile;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_date;
@property (weak, nonatomic) IBOutlet UILabel *label_heart;
@property (weak, nonatomic) IBOutlet UILabel *label_comment;

@end
