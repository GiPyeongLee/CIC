//
//  CounselRoomCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounselRoomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_room;
@property (weak, nonatomic) IBOutlet UILabel *label_room_member;
@property (weak, nonatomic) IBOutlet UILabel *label_room_message;

@end
