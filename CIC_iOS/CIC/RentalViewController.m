//
//  RentalViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 23..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "RentalViewController.h"
#import "LKSegmentControl.h"
#import "RentalCell.h"
#import "UIImage+Async.h"
#import "Define.h"
@interface RentalViewController()<UITableViewDataSource,UITableViewDelegate, LKSegmentDelegate>{
    NSInteger selectedIndex;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@end
@implementation RentalViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.segmentCtrl setSelectedIndex:selectedIndex];
}
- (void)setupSelectedSegement:(NSInteger)index withData:(NSDictionary *)data{
    selectedIndex = index;
    self.dataArray = [[data objectForKey:@"data"]mutableCopy];
    NSLog(@"%@",self.dataArray);
}
#define mark - LKSegmentDelegate

- (void)selectedSegment:(id)sender{
    selectedIndex = [sender tag];
    [self.segmentCtrl setSelectedIndex:selectedIndex];
}

#pragma mark - UITableViewData,Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RentalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentalCell"];
    NSDictionary *equipDic = [self.dataArray objectAtIndex:indexPath.row];
    [UIImage loadFromURL:[NSURL URLWithString:[equipDic valueForKey:@"equip_img"]] callback:^(UIImage *image) {
        cell.img_equipment.image = image;
    }];
    cell.label_name.text = [equipDic valueForKey:@"name"];
    cell.label_pkid.text = [equipDic valueForKey:@"equip_id"];
    cell.label_rentaled.text = Int2Str([[equipDic valueForKey:@"rental_count"] intValue]);
    cell.label_enable.text = Int2Str([[equipDic valueForKey:@"total_count"]intValue]-[[equipDic valueForKey:@"rental_count"]intValue]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
