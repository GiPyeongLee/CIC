//
//  RentalStatusCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentalStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_equipment;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_pkid;
@property (weak, nonatomic) IBOutlet UILabel *label_room;
@property (weak, nonatomic) IBOutlet UIButton *btn_status;
@end
