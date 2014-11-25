//
//  MainViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "MainViewController.h"
#import "IntroViewController.h"
#import "BoardViewController.h"
#import "GraduationViewController.h"
#import "RentalViewController.h"
#import "CounselViewController.h"
#import "LKHttpRequest.h"
@interface MainViewController()
@property (nonatomic,strong) LKHttpRequest *request;
@end
@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.request= [[LKHttpRequest alloc]init];
}

- (IBAction)pushedIntroBtn:(id)sender{
    [self.request postWithURL:kURL_GREETING withParams:nil compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        IntroViewController *VC = (IntroViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"IntroViewController"];
        
        [VC setupSelectedSegement:[sender tag]withData:jsonDic];

        [self.navigationController pushViewController:VC animated:false];
        
    }];
}

- (IBAction)pushedBoardBtn:(id)sender   
{
    // 1 공지사항
    // 2 자유게시판
    // 4 취업게시판
    // 9.사진게시판
    [self.request postWithURL:kURL_BOARD withParams:@{@"main_type":@([sender tag])} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        BoardViewController *VC = (BoardViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"BoardViewController"];
        switch ([sender tag]) {
            case 1:
            case 2:
                [VC preloadData:jsonDic withSelectIndex:[sender tag]-1];
                break;
            case 4:
                [VC preloadData:jsonDic withSelectIndex:2];
                break;
            case 9:
                [VC preloadData:jsonDic withSelectIndex:3];
                break;
            default:
                break;
        }

        
        [self.navigationController pushViewController:VC animated:false];
        
    }];
}

- (IBAction)pushedGraduateBtn:(id)sender {
   GraduationViewController *VC = VIEWCONTROLLER(@"GraduationViewController");
    [self.navigationController pushViewController:VC animated:false];
}
- (IBAction)pushedRentalBtn:(id)sender {
    [self.request postWithURL:kURL_RENTAL_LIST withParams:@{@"status":@(0),@"user_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        RentalViewController *VC = VIEWCONTROLLER(@"RentalViewController");
        [VC setupSelectedSegement:0 withData:jsonDic];
        [self.navigationController pushViewController:VC animated:false];
    }];
}
- (IBAction)pushedCounselBtn:(id)sender {
    CounselViewController *VC = VIEWCONTROLLER(@"CounselViewController");
    
//    if (sharedPref(@"people")&&[sharedPref(@"room") count]>0) {
//        NSLog(@"rooms %@",sharedPref(@"room"));
//        [VC preloadDataWithPeople:sharedPref(@"people") withRoom:sharedPref(@"room")];
//        [self.navigationController pushViewController:VC animated:true];
//    }else{
    
        [self.request postWithURL:kURL_COUNSEL_DATA withParams:@{@"user_id":sharedUserInfo(@"pkid")} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",jsonDic);
            @try {
                [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] forKey:@"people"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"room"] forKey:@"room"];
                
                [VC preloadDataWithPeople:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] withRoom:[[jsonDic objectForKey:@"data"]objectForKey:@"room"]];

            }
            @catch (NSException *exception) {
                [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"people"] forKey:@"people"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[[jsonDic objectForKey:@"data"]objectForKey:@"room"] forKey:@"room"];
                
                [VC preloadDataWithPeople:@[] withRoom:@[]];
            }
            @finally {
                
            }
            
            [self.navigationController pushViewController:VC animated:true];
        }];
//    }

}



@end
