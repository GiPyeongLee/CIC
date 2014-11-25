//
//  ChatViewController.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"

@interface ChatViewController : LKViewController
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
- (void)preloadData:(NSArray *)data withPerson:(NSDictionary *)person;
@end
