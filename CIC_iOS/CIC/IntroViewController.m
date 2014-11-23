//
//  IntroViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 17..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "IntroViewController.h"
#import "LKSegmentControl.h"
#import "LKHttpRequest.h"
#import "UIImage+Async.h"
#import "Define.h"
#import "GreetingCell.h"
#import "IntroCell.h"
#import "MemberCell.h"
#import <MessageUI/MessageUI.h>

@interface IntroViewController()<LKSegmentDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    NSInteger selectedIndex;
    NSMutableDictionary *dataDic;
}
@property (nonatomic,strong) LKHttpRequest *request;
@property (nonatomic,weak) IBOutlet LKSegmentControl *segmentCtrl;
@property (nonatomic,weak) IBOutlet UITableView *m_tableView;
@end
@implementation IntroViewController
- (void)setupSelectedSegement:(NSInteger)index withData:(NSDictionary *)data{
    //무조건 처음에 해주자..
    
    selectedIndex = index;
    
    if(dataDic==nil)
        dataDic = @{}.mutableCopy;
    // Greeting
    [dataDic setObject:data forKey:@"greet"];
    
    
    // Members
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"professors" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    [dataDic setObject:json forKey:@"members"];
    NSLog(@"json %@",json);
}
- (void)viewDidLoad{
    [super viewDidLoad];
    if(dataDic==nil)
        dataDic = @{}.mutableCopy;
    
    [self.segmentCtrl setSelectedIndex:selectedIndex];
    
}

- (void)selectedSegment:(id)sender
{
    selectedIndex = [sender tag];
    
    [self.segmentCtrl setSelectedIndex:[sender tag]];
    [self.m_tableView reloadData];
    NSLog(@"!");
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(selectedIndex==0){
        return 3;
    }
    else if(selectedIndex==1){
        return 3;
    }
    else{
        return [[dataDic objectForKey:@"members"]count];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedIndex==0){
        if(indexPath.row==0){
            return 140.f;
        }else if(indexPath.row==1){
            return 50.f;
        }else{
            NSString *mytitleString = [[dataDic objectForKey:@"greet"] valueForKey:@"greet"];
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
            CGRect rect = [mytitleString boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:attributes
                                                      context:nil];
            
            return rect.size.height+70;
        }
    }else if(selectedIndex==1){
        if(indexPath.row==0){
            return 125.f;
        }else if(indexPath.row==1){
            return 80.f;
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"txt"];
            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
            CGRect rect = [content boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil];
            
            return rect.size.height+70;
            
        }
    }else{
        return 390.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPaths
{
    
    CGRect frame = tableView.frame;
    if(selectedIndex==0){
        static NSString *cellIdentifier = @"GreetingCell";
        // Similar to UITableViewCell, but
        GreetingCell *cell = (GreetingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[GreetingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            if(indexPaths.row==0){
                [cell.profileImg  setFrame:CGRectMake((frame.size.width-100)/2, 20, 100, 100)];
                if(dataDic!=nil){
                    [UIImage loadFromURL:[NSURL URLWithString:[[dataDic objectForKey:@"greet"]valueForKey:@"img"]] callback:^(UIImage *image) {
                        [cell.profileImg setImage:image];
                        cell.profileImg.layer.cornerRadius = 50.f;
                        cell.profileImg.layer.borderWidth = 2.f;
                        cell.profileImg.layer.borderColor = LKButtonColorOrange.CGColor;
                        cell.profileImg.layer.masksToBounds = true;
                    }];
                }
            }else if(indexPaths.row==1){
                [cell.label_major setFrame:CGRectMake(20, 5, 200, 20)];
                [cell.label_major setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:14]];
                [cell.label_major setText:[[dataDic objectForKey:@"greet"]valueForKey:@"major"]];
                
                [cell.label_name setFrame:CGRectMake(20, 27, 200, 20)];
                [cell.label_name setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:14]];
                [cell.label_name setText:[[dataDic objectForKey:@"greet"]valueForKey:@"name"]];
            }
            else{
                NSString *mytitleString = [[dataDic objectForKey:@"greet"] valueForKey:@"greet"];
                NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
                CGRect rect = [mytitleString boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:attributes
                                                          context:nil];
                [cell.label_greeting setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
                [cell.label_greeting setFrame:CGRectMake(20, 5, 280, rect.size.height)];
                cell.label_greeting.numberOfLines =0;
                [cell.label_greeting setText:[[dataDic objectForKey:@"greet"]valueForKey:@"greet"]];
            }
        }
        // Just want to test, so I hardcode the data
        return cell;
    }
    else if(selectedIndex==1){
        static NSString *cellIdentifier = @"IntroCell";
        IntroCell *cell = (IntroCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil) {
            cell = [[IntroCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            if(indexPaths.row==0){
                [cell.profileImg  setFrame:CGRectMake(0,0,320,125)];
                [cell.profileImg setImage:IMAGE(@"cover_img")];
                
            }else if(indexPaths.row==1){
                [cell.label_major setFrame:CGRectMake(20, 10, 200, 20)];
                [cell.label_major setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:14]];
                [cell.label_major setText:@"학과소개"];
                
                [cell.label_name setFrame:CGRectMake(20, 32, 200, 20)];
                [cell.label_name setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:15]];
                [cell.label_name setText:@"컴퓨터정보통신공학과"];
                
                [cell.logoImg setImage:IMAGE(@"img_logo")];
                [cell.logoImg setFrame:CGRectMake(250, 10, 50, 29)];
                
            }
            else{
                NSString *path = [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"txt"];
                NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                
                NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]};
                CGRect rect = [content boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributes
                                                    context:nil];

                [cell.label_greeting setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
                [cell.label_greeting setFrame:CGRectMake(20, 5, 280, rect.size.height)];
                cell.label_greeting.numberOfLines =0;
                [cell.label_greeting setText:content];
            }
            
        }
        // Just want to test, so I hardcode the data
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"MemberCell";
        MemberCell *cell = (MemberCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.containerView.layer.cornerRadius = 14.f;

        NSString *path = [[[dataDic objectForKey:@"members"] objectAtIndex:indexPaths.row] valueForKey:@"img"];
        [cell.profile_img setImage:IMAGE(path)];
        cell.label_name.text = [[[dataDic objectForKey:@"members"] objectAtIndex:indexPaths.row] valueForKey:@"name"];
        cell.label_email.text = [[[dataDic objectForKey:@"members"] objectAtIndex:indexPaths.row] valueForKey:@"email"];
        cell.label_school.text = [[[dataDic objectForKey:@"members"] objectAtIndex:indexPaths.row] valueForKey:@"school"];
        cell.label_major.text = [[[dataDic objectForKey:@"members"] objectAtIndex:indexPaths.row] valueForKey:@"major"];

        return cell;
    }
    
    
}
- (IBAction)pushedCustomBack:(id)sender {
    [self.navigationController popViewControllerAnimated:false];
}
- (IBAction)pushedMailBtn:(id)sender {
    NSLog(@"%@",[(MemberCell *)[[[sender superview]superview] superview] label_email].text);
    
    MFMailComposeViewController* mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@""];
    [mailComposer setToRecipients:@[[(MemberCell *)[[[sender superview]superview] superview] label_email].text]];
    [self presentViewController:mailComposer animated:true completion:false];
}
#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
    
}

@end
