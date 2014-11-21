//
//  BoardDetailViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 19..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "BoardDetailViewController.h"
#import "LKHttpRequest.h"
#import "BoardDetailCell.h"
#import "BoardCommentCell.h"
#import "UIImage+Async.h"
@interface BoardDetailViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) LKHttpRequest *request;
@end

@implementation BoardDetailViewController
- (void)viewDidLoad{
    self.request = [[LKHttpRequest alloc]init];
    NSLog(@"tt : %@",self.title);
    [self.nav_title setText:self.title];
}

- (void)preloadData:(NSDictionary *)data withArticle:(NSDictionary *)article{
    self.dataDic = article.mutableCopy;
    NSMutableString *text = [[self.dataDic valueForKey:@"text"] mutableCopy];
    [self.dataDic setObject:[text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"] forKey:@"text"];
    if([data objectForKey:@"data"]!=nil){
        [self.dataDic setObject:@"comments" forKey:[[data objectForKey:@"data"] objectForKey:@"comments"]];
        [self.dataDic setValue:[[data objectForKey:@"data"] valueForKey:@"isLike"] forKey:@"isLike"];
    }else{
        [self.dataDic setObject:@"comments" forKey:@[].mutableCopy];
        [self.dataDic setValue:@"0" forKey:@"isLike"];
    }
    NSLog(@"%@",self.dataDic);

}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section>=0&&section<=2){
        return 1;
    }else{
        return [[self.dataDic objectForKey:@"comments"]count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 90.f;
    }
    else if(indexPath.section==1){
        NSString *content = [self.dataDic valueForKey:@"text"];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
        CGRect rect = [content boundingRectWithSize:CGSizeMake(257, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        return rect.size.height+50.f;
    }
    else if(indexPath.section==2){
        return 31.f;
    }
    else{
        return 50.f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        // 게시글 윗부분
        BoardDetailCell *cell = (BoardDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"BoardTopCell" forIndexPath:indexPath];
        [UIImage loadFromURL:[NSURL URLWithString:[self.dataDic valueForKey:@"profile_img"]] callback:^(UIImage *image) {
            cell.top_img_profile.image = image;
            cell.top_img_profile.layer.cornerRadius = cell.top_img_profile.frame.size.height/2;
            cell.top_img_profile.layer.masksToBounds = true;
        }];
        cell.top_label_heart.text = [self.dataDic valueForKey:@"like_count"];
        cell.top_label_comment.text = [self.dataDic valueForKey:@"comment_count"];
        cell.top_label_name.text = [self.dataDic valueForKey:@"name"];
        cell.top_label_date.text = [[[self.dataDic valueForKey:@"date"] substringToIndex:10]stringByReplacingOccurrencesOfString:@"-" withString:@". "];
        return cell;
        
    }else if(indexPath.section==1){
        BoardDetailCell *cell = (BoardDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"BoardMiddleCell" forIndexPath:indexPath];
        
      
        cell.middle_label_title.text = [self.dataDic valueForKey:@"title"];
        cell.middle_label_description.text = [self.dataDic valueForKey:@"text"];
        

        return cell;
        
    }else if(indexPath.section==2){
        BoardDetailCell *cell = (BoardDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"BoardBottomCell" forIndexPath:indexPath];
        if([[self.dataDic valueForKey:@"isLike"]intValue]==0){
            [cell.btn_like setSelected:false];
        }else{
            [cell.btn_like setSelected:true];
        }
        [cell.btn_like addTarget:self action:@selector(pushedLikeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_share addTarget:self action:@selector(pushedShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        BoardCommentCell *cell = (BoardCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"BoardCommentCell" forIndexPath:indexPath];
        
        return cell;
    }

}

- (void)pushedLikeBtn:(id)sender{
    NSLog(@"%@",sharedUserInfo(@"pkid"));
    [self.request postWithURL:kURL_BOARD_LIKE withParams:@{@"board_id":[self.dataDic valueForKey:@"pkid"],@"member_id":sharedUserInfo(@"pkid")}compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        if ([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]) {
            [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
        }
    }];

}
- (void)pushedShareBtn:(id)sender{
    
}


@end
