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
        switch (type) {
            case LKButtonTypeWhite:{
                
                
                
                break;
            }
            default:
                break;
        }
    }
    return self;
}
@end
