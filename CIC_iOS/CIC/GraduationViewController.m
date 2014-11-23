//
//  GraduationViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 22..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "GraduationViewController.h"
#import "GraduationDetailViewController.h"
#import "GraduationCell.h"
#import "Define.h"
@interface GraduationViewController()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation GraduationViewController

#pragma mark - UITableViewDelegate,DataSources
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [LKGraduationImageCovers count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GraduationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraduationCell"];
    cell.label_title.text = [LKGraduationTitles objectAtIndex:indexPath.row];
    cell.img_cover.image = IMAGE([LKGraduationImageCovers objectAtIndex:indexPath.row]);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GraduationDetailViewController *VC = VIEWCONTROLLER(@"GraduationDetailViewController");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"graduation" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    
    [VC preloadData:json withTitle:[LKGraduationTitles objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:VC animated:true];
}

@end
