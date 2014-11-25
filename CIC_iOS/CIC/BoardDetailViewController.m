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
#import <KakaoOpenSDK/KakaoOpenSDK.h>
@interface BoardDetailViewController() <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextView *m_textView;
@property (nonatomic,strong) LKHttpRequest *request;
@property(nonatomic, retain) NSMutableDictionary *kakaoTalkLinkObjects;

@end

@implementation BoardDetailViewController
@synthesize kakaoTalkLinkObjects;
- (void)viewDidLoad{
    self.request = [[LKHttpRequest alloc]init];
    kakaoTalkLinkObjects = @{}.mutableCopy;
    NSLog(@"tt : %@",self.title);
    [self.nav_title setText:self.title];
    
    KakaoTalkLinkAction *iphoneAppAction = [KakaoTalkLinkAction createAppAction:KakaoTalkLinkActionOSPlatformIOS
                                                                     devicetype:KakaoTalkLinkActionDeviceTypePhone
                                                                      execparam:@{@"board_id" : [self.dataDic valueForKey:@"pkid"]}];
    
//    KakaoTalkLinkAction *ipadAppAction = [KakaoTalkLinkAction createAppAction:KakaoTalkLinkActionOSPlatformIOS
//                                                                   devicetype:KakaoTalkLinkActionDeviceTypePad
//                                                                    execparam:@{@"a" : @"p", @"b" : @"2", @"c" : @"3"}];
    
    KakaoTalkLinkObject *buttonObj = [KakaoTalkLinkObject createAppButton:[self.dataDic valueForKey:@"title"]
                                                                  actions:@[iphoneAppAction]];
    [kakaoTalkLinkObjects setObject:buttonObj forKey:@"title"];
}

- (void)preloadData:(NSDictionary *)data withArticle:(NSDictionary *)article{
    self.dataDic = article.mutableCopy;
    NSMutableString *text = [[self.dataDic valueForKey:@"text"] mutableCopy];
    [self.dataDic setObject:[text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"] forKey:@"text"];
    NSLog(@"%lu",[[[data objectForKey:@"data"] objectForKey:@"comments"]count]);
    if([data objectForKey:@"data"]!=nil){
        [self.dataDic setObject:[[[data objectForKey:@"data"] objectForKey:@"comments"] copy] forKey:@"comments"];
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
    }else if(section==3){
        NSLog(@"%@",[[self.dataDic objectForKey:@"comments"] class]);
        return [[self.dataDic objectForKey:@"comments"]count];
    }else{
        return 0;
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
    else if(indexPath.section==3){
        NSString *content = [[[self.dataDic objectForKey:@"comments"] objectAtIndex:indexPath.row] valueForKey:@"text"];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:12]};
        CGRect rect = [content boundingRectWithSize:CGSizeMake(221, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];

        NSLog(@"%f",rect.size.height);
        return rect.size.height+40<50?50:rect.size.height+40;
    }
    else{
        return 0;
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
        cell.label_name.text = [[[self.dataDic objectForKey:@"comments"] objectAtIndex:indexPath.row]valueForKey:@"name"];
        cell.label_date.text = [[[[self.dataDic objectForKey:@"comments"] objectAtIndex:indexPath.row]valueForKey:@"date"] substringToIndex:10];
        cell.label_description.text = [[[self.dataDic objectForKey:@"comments"] objectAtIndex:indexPath.row]valueForKey:@"text"];
        [UIImage loadFromURL:[NSURL URLWithString:[[[self.dataDic objectForKey:@"comments"] objectAtIndex:indexPath.row]valueForKey:@"profile_img"]] callback:^(UIImage *image) {
            cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.height/2;
            cell.img_profile.layer.masksToBounds = true;
            cell.img_profile.image = image;
        }];
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
    
    if ([KOAppCall canOpenKakaoTalkAppLink]) {
        [KOAppCall openKakaoTalkAppLink:[kakaoTalkLinkObjects allValues]];
    }
}

#pragma mark - UITextViewDelegate
- (void)keyboardWillChange:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:@"textViewAnimate" context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        
        CGRect newFrame = self.textInputView.frame;
        CGRect tableFrame = self.m_tableView.frame;
        
        newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
        tableFrame.size.height -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
        self.textInputView.frame = newFrame;
        self.m_tableView.frame = tableFrame;
        [UIView commitAnimations];
    });
}
- (IBAction)pushedBoardBtn:(id)sender {
    NSLog(@"%@",@{@"board_id":[self.dataDic valueForKey:@"pkid"],@"member_id":sharedUserInfo(@"pkid"),@"comment":self.m_textView.text});
    [self.request postWithURL:kURL_BOARD_COMMENT_WRITE withParams:@{@"board_id":[self.dataDic valueForKey:@"pkid"],@"member_id":sharedUserInfo(@"pkid"),@"comment":self.m_textView.text}compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        if ([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]) {
            NSDictionary *dic = @{@"name":sharedUserInfo(@"name"),@"profile_img":sharedUserInfo(@"profile_img"),@"date":[[jsonDic objectForKey:@"data"] valueForKey:@"date"],@"text":self.m_textView.text};
            
            NSMutableArray *array = [[self.dataDic objectForKey:@"comments"]mutableCopy];
            [array addObject:dic];
            [self.dataDic setObject:array forKey:@"comments"];
            [self.m_textView setText:@""];
            [self.m_textView resignFirstResponder];
            [self.m_tableView reloadData];
        }
    }];

}



@end
