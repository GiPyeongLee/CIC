//
//  RentalAdminCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentalAdminCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_equipment;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_pkid;
@property (weak, nonatomic) IBOutlet UIButton *btn_accept;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@end
