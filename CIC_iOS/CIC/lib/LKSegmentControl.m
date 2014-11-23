//
//  LKSegmentControl.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKSegmentControl.h"
#import "Define.h"
#define kINTRO_IMAGE_UNTAP @[@"btn_greeting_untap",@"btn_intro_untap",@"btn_member_untap"]
#define kINTRO_IMAGE_TAP @[@"btn_greeting_tap",@"btn_intro_tap",@"btn_member_tap"]
#define kBOARD_IMAGE_UNTAP @[@"btn_noticeboard",@"btn_freeboard",@"btn_jobboard",@"btn_photoboard"]
#define kBOARD_IMAGE_TAP @[@"btn_noticeboard_red",@"btn_freeboard_red",@"btn_jobboard_red",@"btn_photoboard_red"]

#define kRENTAL_IMAGE_UNTAP @[@"btn_list_untap",@"btn_standby_untap",@"btn_rental_untap",@"btn_finish_untap"]
#define kRENTAL_IMAGE_TAP @[@"btn_list_tap",@"btn_standby_tap",@"btn_rental_tap",@"btn_finish_untap"]

@implementation LKSegmentControl
@synthesize delegate;

//-(id)initWithFrame:(CGRect)frame withType:(LKSegmentControlType)type{
//    self = [super initWithFrame:frame];
//    if(self){
//        switch (type) {
//            case LKSegmentTypeIntro:
//            {
//                float width = frame.size.width/[kLKSegIntroTitle count];
//                float offsetX = 0.f;
//                for (int i=0; [kLKSegIntroTitle count]; i++) {
//                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    [btn setBackgroundImage:IMAGE(@"btn_untap") forState:UIControlStateNormal];
//                    [btn setBackgroundImage:IMAGE(@"btn_tap") forState:UIControlStateSelected];
//                    [btn setTitle:[kLKSegIntroTitle objectAtIndex:i] forState:UIControlStateNormal];
//                    [btn setTitle:[kLKSegIntroTitle objectAtIndex:i] forState:UIControlStateSelected];
//                    [btn setTitleColor:LKButtonColorNavi forState:UIControlStateNormal];
//                    [btn setTitleColor:LKButtonColorWhite forState:UIControlStateSelected];
//                    [btn addTarget:delegate action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
//                    [btn setTag:i];
//                    [btn setFrame:CGRectMake(offsetX, 0, width, 40)];
//                    offsetX+=width;
//                    [self addSubview:btn];
//                }
//                break;
//            }
//            default:
//                break;
//        }
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        CGRect frame = self.frame;
        switch (self.tag) {
            case LKSegmentTypeIntro:
            {
                float width = frame.size.width/[kLKSegIntroTitle count];
                float offsetX = 0.f;
                for (int i=0;i<[kLKSegIntroTitle count]; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    NSString *tapName = kINTRO_IMAGE_TAP[i];
                    NSString *untapName = kINTRO_IMAGE_UNTAP[i];
                    [btn setImage:IMAGE(untapName) forState:UIControlStateNormal];
                    [btn setImage:IMAGE(tapName) forState:UIControlStateSelected];
                    [btn addTarget:delegate action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTag:i];
                    [btn setFrame:CGRectMake(offsetX, 0, width, frame.size.height)];
                    offsetX+=width;
                    [self addSubview:btn];
                }
                break;
            }
            case LKSegmentTypeBoard:{
                float width = frame.size.width/[kLKSegBoardTitle count];
                float offsetX = 0.f;
                for (int i=0;i<[kLKSegBoardTitle count]; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    NSString *tapName = kBOARD_IMAGE_TAP[i];
                    NSString *untapName = kBOARD_IMAGE_UNTAP[i];
                    [btn setImage:IMAGE(untapName) forState:UIControlStateNormal];
                    [btn setImage:IMAGE(tapName) forState:UIControlStateSelected];
                    [btn addTarget:delegate action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTag:i];
                    [btn setFrame:CGRectMake(offsetX, 0, width, frame.size.height)];
                    offsetX+=width;
                    [self addSubview:btn];
                }
                break;
            }
            case LKSegmentTypeRental:{
                float width = frame.size.width/[kRENTAL_IMAGE_UNTAP count];
                float offsetX = 0.f;
                for (int i=0;i<[kRENTAL_IMAGE_UNTAP count]; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    NSString *tapName = kRENTAL_IMAGE_TAP[i];
                    NSString *untapName = kRENTAL_IMAGE_UNTAP[i];
                    [btn setImage:IMAGE(untapName) forState:UIControlStateNormal];
                    [btn setImage:IMAGE(tapName) forState:UIControlStateSelected];
                    [btn addTarget:delegate action:@selector(selectedSegment:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTag:i];
                    [btn setFrame:CGRectMake(offsetX, 0, width, frame.size.height)];
                    offsetX+=width;
                    [self addSubview:btn];
                }
                break;
            }
            default:
                break;
        }
    }
    return self;
}
- (void)clearSubViews{
    for (UIButton *btn in self.subviews) {
        if([btn isKindOfClass:[UIButton class]]){
            [btn setSelected:false];
        }
    }
}
- (void)setSelectedIndex:(NSInteger)index{
    for (UIButton *btn in self.subviews) {
        if([btn isKindOfClass:[UIButton class]]&&btn.tag==index){
            [btn setSelected:true];
        }else{
            [btn setSelected:false];
        }
    }
}
- (NSString *)getSegemntTitleWithIndex:(NSInteger)index{
    switch (self.tag) {
        case LKSegmentTypeIntro:{
            return [kLKSegIntroTitle objectAtIndex:index];
            break;
        }
        case LKSegmentTypeBoard:{
            return [kLKSegBoardTitle objectAtIndex:index];
            break;
        }
         default:
            break;
    }
    return @"";
}
@end
