//
//  LKButton.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//  화면 크기에 따른 버튼들을 모두 적용시켜주기위해 만든 클래스 ( 이미지를 없애고 해당 버튼들로만 작업 진행할 예정

#import "LKButton.h"
#import "Define.h"
@implementation LKButton

-(id)initWithFrame:(CGRect)frame withType:(LKButtonType)type{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"%s",__FUNCTION__);
        [self.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:frame.size.height/3.5]];

        switch (type) {
            case LKButtonTypeWhite:{
                self.backgroundColor = LKButtonColorWhite;
                break;
            }
            case LKButtonTypeGray:{
                self.backgroundColor = LKButtonColorGray;
                break;
            }
            case LKButtonTypeOrange:{
                self.backgroundColor = LKButtonColorOrange;
                break;
            }
            case LKButtonTypeOrangeRound :{
                self.backgroundColor = LKButtonColorOrange;
                self.layer.cornerRadius = frame.size.height/3.5;
                self.layer.masksToBounds = true;
                break;
            }
            case LKButtonTypeNavi:{
                self.backgroundColor = LKButtonColorNavi;
                break;
            }
            case LKButtonTypeNaviRound:{
                self.backgroundColor = LKButtonColorNavi;
                self.layer.cornerRadius = frame.size.height/3.5;
                self.layer.masksToBounds = true;
                break;
            }
            default:
                break;
        }
        
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    NSLog(@"%s",__FUNCTION__);
    CGRect frame = self.frame;
    [self.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:frame.size.height/3]];
    /*
     LKButtonTypeWhite =0,
     LKButtonTypeWhiteRound,
     LKButtonTypeOrange,
     LKButtonTypeOrangeRound,
     LKButtonTypeNavi,
     LKButtonTypeNaviRound,
     LKButtonTypeGray,
     LKButtonTypeGrayRound
     */
    if(self){
        switch (self.tag) {
            case LKButtonTypeWhite:{
                self.backgroundColor = LKButtonColorWhite;
                break;
            }
            case LKButtonTypeOrange:{
                self.backgroundColor = LKButtonColorOrange;
                break;
            }
            case LKButtonTypeOrangeRound :{
                self.backgroundColor = LKButtonColorOrange;
                self.layer.cornerRadius = frame.size.height/3;
                self.layer.masksToBounds = true;
                break;
            }
            case LKButtonTypeNavi:{
                self.backgroundColor = LKButtonColorNavi;
                break;
            }
            case LKButtonTypeNaviRound:{
                self.backgroundColor = LKButtonColorNavi;
                self.layer.cornerRadius = frame.size.height/3;
                self.layer.masksToBounds = true;
                break;
            }
            case LKButtonTypeGray:{
                self.backgroundColor = LKButtonColorGray;
                break;
            }
            case LKButtonTypeGrayRound:{
                self.backgroundColor = LKButtonColorGray;
                self.layer.cornerRadius = frame.size.height/3;
                self.layer.masksToBounds = true;
                break;
            }
            default:
                break;
        }
    }
    return self;
}


@end
