//
//  LKView.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKView.h"

@implementation LKView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL isKeyboardAppearance = false;
    id textField = NULL;
    for (id view in self.subviews) {
        if([view isKindOfClass:[UITextField class]]){
            if([view isFirstResponder]){
                isKeyboardAppearance = true;
                textField = view;
                break;
            }
        }
    }
    for (id view in self.subviews) {
        if(![view isKindOfClass:[UITextField class]]){
            if(isKeyboardAppearance){
                [textField resignFirstResponder];
                break;
            }
        }
    }

}


@end
