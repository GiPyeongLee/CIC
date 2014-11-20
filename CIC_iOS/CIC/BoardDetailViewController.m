//
//  BoardDetailViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 19..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "BoardDetailViewController.h"
#import "LKHttpRequest.h"
@interface BoardDetailViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) LKHttpRequest *request;
@end

@implementation BoardDetailViewController
- (void)viewDidLoad{
    self.request = [[LKHttpRequest alloc]init];
}

- (void)preloadData:(NSDictionary *)data withArticle:(NSDictionary *)article{
    
}

#pragma mark - UITableViewDelegate


@end
