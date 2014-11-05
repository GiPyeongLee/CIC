//
//  ViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "ViewController.h"
#import "LKHttpRequest.h"
@interface ViewController ()
@property (nonatomic,strong) LKHttpRequest *request;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.request = [[LKHttpRequest alloc]init];
    [self.request postWithURL:@"https://cic.hongik.ac.kr/api/login.php" withParams:@{@"user_id":@"a889056",@"user_pw":@""} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"jsonArray : %@",jsonDic);

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
