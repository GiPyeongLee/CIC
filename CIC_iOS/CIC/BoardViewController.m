//
//  BoardViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 18..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardDetailViewController.h"
#import "BoardCell.h"
#import "LKSegmentControl.h"
#import "Define.h"
#import "UIImage+Async.h"
#import "LKHttpRequest.h"
#import "LKLoadingView.h"
@interface BoardViewController() <LKSegmentDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger beforeIndex;
    NSInteger selectedIndex;
    NSInteger boardType;
    UIActivityIndicatorView *spinner;
}
@property (nonatomic,strong) LKHttpRequest *request;
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@property (nonatomic,weak) IBOutlet UITableView *m_tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation BoardViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.request = [[LKHttpRequest alloc]init];
    [self.segmentCtrl setSelectedIndex:selectedIndex];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl setTag:999];
    refreshControl.tintColor = LKButtonColorNavi;
    [refreshControl addTarget:self action:@selector(changeSorting:) forControlEvents:UIControlEventValueChanged];
    [self.m_tableView addSubview:refreshControl];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    self.m_tableView.tableFooterView = footerView;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner stopAnimating];
    spinner.hidesWhenStopped = true;
    spinner.tintColor = LKButtonColorNavi;
    spinner.frame = CGRectMake(0, 0, 320, 44);
    [self.m_tableView.tableFooterView addSubview:spinner];
    

    UILabel *label_more = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.m_tableView.tableFooterView.frame.size.width, 44)];
    [label_more setText:@"▼"];
    [label_more setTextAlignment:NSTextAlignmentCenter];
    [label_more setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:32]];
    [label_more setTextColor:LKButtonColorNavi];
    [label_more setBackgroundColor:[UIColor clearColor]];
    [label_more setTag:888];
    [self.m_tableView.tableFooterView addSubview:label_more];

}
- (void)addData:(id)sender{
    [spinner stopAnimating];
    [self.m_tableView reloadData];
    [[self.m_tableView.tableFooterView viewWithTag:888]setAlpha:1.0f];
}

- (void)changeSorting:(id)sender{
    [self.request postWithURL:kURL_BOARD withParams:@{@"main_type":kLKSegBoardType[selectedIndex]} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
        @try {
            self.dataArray = [[NSMutableArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
        }
        @catch (NSException *exception) {
            self.dataArray = @[].mutableCopy;
            NSLog(@"%@",exception);
        }
        @finally {
            [self performSelector:@selector(refreshTableView:) withObject:sender afterDelay:1];
        }
    }];

    
    
}
- (void)refreshTableView:(id)sender{
    [sender endRefreshing];
    
    if(beforeIndex<selectedIndex){
        [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    }else if(beforeIndex>selectedIndex){
        [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        [self.m_tableView reloadData];
    }
        [LKLoadingView hideInView:self.view];

}
- (void)preloadData:(NSDictionary *)data withSelectIndex:(NSInteger)index{
    @try {
        self.dataArray = [[NSMutableArray alloc]initWithArray:[data objectForKey:@"data"]];
    }
    @catch (NSException *exception) {
        self.dataArray = @[].mutableCopy;
        NSLog(@"%@",exception);
    }
    @finally {
        selectedIndex = index;
        NSLog(@"%@",self.dataArray);
    }

}

- (void)selectedSegment:(id)sender
{
    [LKLoadingView showInView:self.view];
    beforeIndex = selectedIndex;
    selectedIndex = [sender tag];
    [self.segmentCtrl setSelectedIndex:[sender tag]];
    if(beforeIndex!=selectedIndex)
    [self changeSorting:[self.m_tableView viewWithTag:999]];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"BoardCell";
    BoardCell *cell = (BoardCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell!=nil){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *userDic = [self.dataArray objectAtIndex:indexPath.row];
        cell.label_date.text = [[[userDic valueForKey:@"date"]substringToIndex:10]stringByReplacingOccurrencesOfString:@"-" withString:@". "];
        cell.label_name.text = [userDic valueForKey:@"name"];
        cell.label_description.text = [[userDic valueForKey:@"text"] substringToIndex:[[userDic valueForKey:@"text"] length]<70?[[userDic valueForKey:@"text"] length]:70];
        cell.label_heart.text = Int2Str([[userDic valueForKey:@"like_count"]intValue]);
        cell.label_comment.text = Int2Str([[userDic valueForKey:@"comment_count"]intValue]);
        cell.label_title.text = [userDic valueForKey:@"title"];
        
        [UIImage loadFromURL:[NSURL URLWithString:[userDic valueForKey:@"profile_img"]] callback:^(UIImage *image) {
            cell.image_profile.image = image;
            cell.image_profile.layer.cornerRadius = cell.image_profile.frame.size.height/2;
            cell.image_profile.layer.masksToBounds = true;
        }];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 144.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pkid"]);
  [self.request postWithURL:kURL_BOARD_COMMENT withParams:@{@"board_id":[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"pkid"],@"member_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
      BoardDetailViewController *VC = (BoardDetailViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"BoardDetailViewController"];
      NSLog(@"jsonDic %@",jsonDic);
      [VC preloadData:jsonDic withArticle:[self.dataArray objectAtIndex:indexPath.row]];
      VC.title = [self.segmentCtrl getSegemntTitleWithIndex:selectedIndex];
      [self.navigationController pushViewController:VC animated:false];

  }];
}

#pragma mark - add Data
- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate{
    
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        NSLog(@"load more data");
        [UIView animateWithDuration:0.5f animations:^{
            [[self.m_tableView.tableFooterView viewWithTag:888]setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [spinner startAnimating];
        }];
        @try {
            [self.request postWithURL:kURL_BOARD withParams:@{@"main_type":kLKSegBoardType[selectedIndex],@"date":[[self.dataArray lastObject] valueForKey:@"date"]} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                @try {
                    [self.dataArray addObjectsFromArray:[jsonDic objectForKey:@"data"]];
                }
                @catch (NSException *exception) {
                    self.dataArray = @[].mutableCopy;
                    NSLog(@"%@",exception);
                }
                @finally {
                    
                    [self performSelector:@selector(addData:) withObject:nil afterDelay:1];
                }
                
                
            }];

        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {

        }
       
    }
}

@end
