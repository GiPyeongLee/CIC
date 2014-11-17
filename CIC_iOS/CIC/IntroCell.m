//
//  IntroCell.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "IntroCell.h"

@implementation IntroCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.logoImg = [[UIImageView alloc]init];
        self.profileImg = [[UIImageView alloc]init];
        self.label_name = [[UILabel alloc]init];
        self.label_major = [[UILabel alloc]init];
        
        
        self.label_greeting = [[UILabel alloc]init];
        self.profileImg.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:self.profileImg];
        [self addSubview:self.label_greeting];
        [self addSubview:self.label_major];
        [self addSubview:self.label_name];
        [self addSubview:self.logoImg];
        // configure control(s)
        
    }
    return self;
}
@end
