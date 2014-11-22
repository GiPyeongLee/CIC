//
//  LKChatTableView.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 22..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKChatTableView.h"

@implementation LKChatTableView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview touchesEnded:touches withEvent:event];
}
@end
