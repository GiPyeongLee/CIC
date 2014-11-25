//
//  CounselViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "CounselViewController.h"
#import "ChatViewController.h"
#import "LKSegmentControl.h"
#import "CounselPeopleCell.h"
#import "CounselRoomCell.h"
#import "UIImage+Async.h"
#import "LKHttpRequest.h"
#import "LKLoadingView.h"
@interface CounselViewController() <LKSegmentDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectedIndex;
}
@property (nonatomic,strong) LKHttpRequest *request;
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@property (nonatomic,weak) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end
@implementation CounselViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.request = [[LKHttpRequest alloc]init];
    
    [self.segmentCtrl setSelectedIndex:selectedIndex];
    [self.m_tableView reloadData];
}
-(void)preloadDataWithPeople:(NSArray *)peopleArray withRoom:(NSArray *)roomArray{
    self.dataDic = @{@"people":peopleArray,@"room":roomArray    }.mutableCopy;
}

- (void)selectedSegment:(id)sender
{
    [LKLoadingView showInView:self.view];
    [self requestNewData:[sender tag]];
    


}
- (void)requestNewData:(NSInteger)tag{
    [self.request postWithURL:kURL_COUNSEL_DATA withParams:@{@"user_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"%@",jsonDic);
        @try {
            [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] forKey:@"people"];
            [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"room"] forKey:@"room"];
        }
        @catch (NSException *exception) {
            [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] forKey:@"people"];
            [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"room"] forKey:@"room"];
        }
        @finally {
            selectedIndex = tag;
            [self.segmentCtrl setSelectedIndex:tag];
            [LKLoadingView hideInView:self.view];
            [self.dataDic setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] forKey:@"people"];
            [self.dataDic setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"room"] forKey:@"room"];
            [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
       }];

}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(selectedIndex==0)
        return [[self.dataDic objectForKey:@"people"]count];
    else
        return [[self.dataDic objectForKey:@"room"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex==0)
    {
        NSDictionary *user = [[self.dataDic objectForKey:@"people"]objectAtIndex:indexPath.row];
        CounselPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselPeopleCell" forIndexPath:indexPath];
        if(cell){
            [UIImage loadFromURL:[NSURL URLWithString:[user valueForKey:@"profile_img"]] callback:^(UIImage *image) {
                cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.height/2;
                cell.img_profile.layer.masksToBounds = true;
                cell.img_profile.image = image;
            }];
            cell.label_name.text = [user valueForKey:@"name"];
        }
        return cell;
    }else if(selectedIndex==1)
    {
        NSDictionary *user = [[self.dataDic objectForKey:@"room"]objectAtIndex:indexPath.row];
        NSLog(@"%@",user);
        CounselRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselRoomCell"];
        if(cell){
            [UIImage loadFromURL:[NSURL URLWithString:[user valueForKey:@"profile_img"]] callback:^(UIImage *image) {
                cell.img_room.layer.cornerRadius = cell.img_room.frame.size.height/2;
                cell.img_room.layer.masksToBounds = true;
                cell.img_room.image = image;
            }];
            cell.label_room_member.text = [user valueForKey:@"name"];
            cell.label_room_message.text = [user valueForKey:@"last_message"];
        }
        return cell;
    }
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedIndex==0){
        
        NSDictionary *user = [[self.dataDic objectForKey:@"people"]objectAtIndex:indexPath.row];
        if([[user valueForKey:@"pkid"]isEqualToString:sharedUserInfo(@"pkid")])
            return;
        
        for (NSDictionary *dic in [self.dataDic objectForKey:@"room"]) {
            if([[dic valueForKey:@"pkid"]isEqualToString:[user valueForKey:@"pkid"]]){
                user = dic;
            }
        }
        
        ChatViewController *VC = VIEWCONTROLLER(@"ChatViewController");
        if(sharedPref(@"chat")){
            NSDictionary *chatDic = sharedPref(@"chat");
            NSArray *array = [chatDic objectForKey:[user valueForKey:@"pkid"]];
            [VC preloadData:array withPerson:user];
        }else{
           [VC preloadData:nil withPerson:user];
        }
        

        [self.navigationController pushViewController:VC animated:true];
    }
    else if(selectedIndex==1){
        NSDictionary *user = [[self.dataDic objectForKey:@"room"]objectAtIndex:indexPath.row];
        
        if([[user valueForKey:@"pkid"]isEqualToString:sharedUserInfo(@"pkid")])
            return;
        
        ChatViewController *VC = VIEWCONTROLLER(@"ChatViewController");
        if(sharedPref(@"chat")){
            NSDictionary *chatDic = sharedPref(@"chat");
            NSArray *array = [chatDic objectForKey:[user valueForKey:@"pkid"]];
            [VC preloadData:array withPerson:user];
        }else{
            
            [VC preloadData:nil withPerson:user];
        }
        
        
        [self.navigationController pushViewController:VC animated:true];
    }
}

@end
