//
//  BoardCommentCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 20..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"

@interface BoardCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_description;
@property (weak, nonatomic) IBOutlet UILabel *label_date;
@property (weak, nonatomic) IBOutlet UIImageView *img_profile;

@end
