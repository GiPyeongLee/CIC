//
//  BoardViewController.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 18..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"

@interface BoardViewController : LKViewController
- (void)preloadData:(NSDictionary *)data withSelectIndex:(NSInteger)index;
@end
