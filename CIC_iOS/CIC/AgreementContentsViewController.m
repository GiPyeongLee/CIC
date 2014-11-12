//
//  AgreementContentsViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 12..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "AgreementContentsViewController.h"
@interface AgreementContentsViewController()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextView *textView_contents;

@end
@implementation AgreementContentsViewController
- (void)viewDidLoad{
    
}
- (void)initWithType:(int)type{
    if(type==0){
         dispatch_async(dispatch_get_main_queue(), ^{
        [self.label_title setText:@"개인정보 이용약관"];
             NSString *path = [[NSBundle mainBundle] pathForResource:@"agreement_1" ofType:@"txt"];
             NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
             [self.textView_contents setText:content];

         });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.label_title setText:@"개인정보 제3자 정보제공"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"agreement_2" ofType:@"txt"];
            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            [self.textView_contents setText:content];
        });
    }
}
@end
