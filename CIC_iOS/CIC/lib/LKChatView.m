//
//  LKChatView.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 22..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKChatView.h"

@implementation LKChatView
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.userInteractionEnabled = true;

    }
    return self;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__FUNCTION__);
    for (id view in self.subviews) {
        if([view isKindOfClass:[UIView class]]){
            for (id subView in [view subviews]) {
                if([subView isKindOfClass:[UITextView class]]){
                    if([subView isFirstResponder]){
                        [subView resignFirstResponder];
                        break;
                    }
                }
            }
        }
    }
}

@end
