//
//  IntroCell.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroCell : UITableViewCell
@property (nonatomic, strong) UIImageView *profileImg;
@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic,strong) UILabel *label_major;
@property (nonatomic,strong) UILabel *label_name;
@property (nonatomic,strong) UILabel *label_greeting;

@end
