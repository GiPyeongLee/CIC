//
//  MainViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "MainViewController.h"
#import "IntroViewController.h"
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



@end
