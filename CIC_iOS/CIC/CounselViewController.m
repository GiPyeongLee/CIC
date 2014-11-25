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
@interface CounselViewController() <LKSegmentDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectedIndex;
}
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@property (nonatomic,weak) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end
@implementation CounselViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%@",self.dataDic);
    [self.segmentCtrl setSelectedIndex:selectedIndex];
    [self.m_tableView reloadData];
}
-(void)preloadDataWithPeople:(NSArray *)peopleArray withRoom:(NSArray *)roomArray{
    self.dataDic = @{@"people":peopleArray,@"room":roomArray}.mutableCopy;
}

- (void)selectedSegment:(id)sender
{
    selectedIndex = [sender tag];
    [self.segmentCtrl setSelectedIndex:[sender tag]];
    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
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
        CounselRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselRoomCell"];
        return cell;
    }
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *VC = VIEWCONTROLLER(@"ChatViewController");
    [VC preloadData:nil withTitle:[[[self.dataDic objectForKey:@"people"] objectAtIndex:indexPath.row]valueForKey:@"name"]];
    [self.navigationController pushViewController:VC animated:true];
}

@end
