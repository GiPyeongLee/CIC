//
//  BoardDetailViewController.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 19..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"

@interface BoardDetailViewController : LKViewController
@property (weak, nonatomic) IBOutlet UILabel *nav_title;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
- (void)preloadData:(NSDictionary *)data withArticle:(NSDictionary *)article;
@end
