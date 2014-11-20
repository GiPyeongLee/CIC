//
//  BoardDetailCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 20..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardDetailCell : UITableViewCell

// These Objects are in Board Top Cell
@property (weak, nonatomic) IBOutlet UIImageView *top_img_profile;
@property (weak, nonatomic) IBOutlet UILabel *top_label_name;
@property (weak, nonatomic) IBOutlet UILabel *top_label_date;
@property (weak, nonatomic) IBOutlet UILabel *top_label_heart;
@property (weak, nonatomic) IBOutlet UILabel *top_label_comment;

// These Objects are in Board Middle Cell
@property (weak, nonatomic) IBOutlet UILabel *middle_label_title;
@property (weak, nonatomic) IBOutlet UILabel *middle_label_description;

// These Objects are Board Buttons
@property (weak, nonatomic) IBOutlet UIButton *btn_like;
@property (weak, nonatomic) IBOutlet UIButton *btn_share;




@end
