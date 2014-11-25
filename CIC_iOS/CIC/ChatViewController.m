//
//  ChatViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "ChatViewController.h"
#import "LKHttpRequest.h"
#import "CounselSenderCell.h"
#import "CounselMyCell.h"
#import "UIImage+Async.h"
@interface ChatViewController() <UITableViewDataSource,UITableViewDelegate>
{
    NSTimer *pollingTimer;
}
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextView *m_textView;
@property (nonatomic,strong) NSDictionary *personDic;
@property (nonatomic,strong) NSMutableArray *chatArray;
@property (nonatomic,strong) LKHttpRequest *request;
@end
@implementation ChatViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.request = [[LKHttpRequest alloc]init];
    self.nav_title.text = self.title;
    
}
- (void)preloadData:(NSArray *)data withPerson:(NSDictionary *)person{
    self.personDic = person;
    person = nil;
    
    self.title = [self.personDic valueForKey:@"name"];

    if(data!=nil)
        self.chatArray = data.mutableCopy;
    else{
        self.chatArray = @[].mutableCopy;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(pollingTimer==nil)
        pollingTimer =  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pollingMessage) userInfo:nil repeats:true];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [pollingTimer invalidate];
    pollingTimer = nil;
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

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.chatArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:16]};
    CGRect rect = [[[self.chatArray objectAtIndex:indexPath.row] valueForKey:@"message"] boundingRectWithSize:CGSizeMake(158, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    
    NSLog(@"%f",rect.size.height);
    return rect.size.height+50<50?50:rect.size.height+50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[self.chatArray objectAtIndex:indexPath.row] valueForKey:@"fk_sender_id"]isEqualToString:sharedUserInfo(@"pkid")]){
        CounselMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselMyCell"];
        cell.label_message.text = [[self.chatArray objectAtIndex:indexPath.row] valueForKey:@"message"];
        return cell;
    }else{
        CounselSenderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselSenderCell"];
        [UIImage loadFromURL:[NSURL URLWithString:[[self.chatArray objectAtIndex:indexPath.row] valueForKey:@"profile_img"]] callback:^(UIImage *image) {
            cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.height/2;
            cell.img_profile.layer.masksToBounds = true;
            cell.img_profile.image = image;
        }];
        cell.label_message.text = [[self.chatArray objectAtIndex:indexPath.row] valueForKey:@"message"];
        return cell;
    }

}
- (IBAction)pushedSendBtn:(id)sender
{
    NSLog(@"%@",self.m_textView.text);
    NSLog(@"%@",@{@"person_id":[self.personDic valueForKey:@"pkid"],@"user_id":sharedUserInfo(@"pkid"),@"message":self.m_textView.text});

        [self.request postWithURL:kURL_SENDING_MESSAGE withParams:@{@"person_id":[self.personDic valueForKey:@"pkid"],@"user_id":sharedUserInfo(@"pkid"),@"message":self.m_textView.text} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@ : %@",jsonDic,error);
            if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]){
                [self.chatArray addObject:@{@"room_id":[[jsonDic objectForKey:@"data"] valueForKey:@"room_id"],@"fk_receiver_id":[self.personDic valueForKey:@"pkid"],@"fk_sender_id":sharedUserInfo(@"pkid"),@"message":self.m_textView.text}];
                if([[NSUserDefaults standardUserDefaults] objectForKey:@"chat"]){
                    NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"chat"] mutableCopy];
                    [dic setObject:self.chatArray forKey:[self.personDic valueForKey:@"pkid"]];
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"chat"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@{[self.personDic valueForKey:@"pkid"]:self.chatArray} forKey:@"chat"];
                }
                if([[NSUserDefaults standardUserDefaults]objectForKey:@"room"]){
//                    NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults]objectForKey:@"room"]mutableCopy];
//                    [dic setValue:self.m_textView.text forKey:@"last_message"];
//                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"room"];
                }
                [self.m_tableView reloadData];
            }
            [self.m_textView setText:@""];
            [self.m_textView resignFirstResponder];
        }];
}

- (void)pollingMessage{
    NSLog(@"%s",__FUNCTION__);
    
    NSString *roomID = @"";
    if ([self.chatArray count]==0&&[self.personDic valueForKey:@"fk_room_id"]) {
        return;
    }
    
    if([self.personDic valueForKey:@"fk_room_id"])
        roomID = [self.personDic valueForKey:@"fk_room_id"];

        //    dispatch_asyn
//    dispatch_async(dispatch_get_main_queue(), ^{
    
    NSLog(@"%@",@{@"room_id":roomID,@"user_id":sharedUserInfo(@"pkid"),@"person_id":[self.personDic valueForKey:@"pkid"]});
    [self.request postWithURL:kURL_POLLING_MESSAGE withParams:@{@"room_id":roomID,@"user_id":sharedUserInfo(@"pkid"),@"person_id":[self.personDic valueForKey:@"pkid"]} compelete:^(NSData *data, NSURLResponse *response, NSError *error) {
          NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
         if([[jsonDic valueForKey:@"status"]isEqualToString:kREQUEST_SUCCESS]){
             NSLog(@"%@",jsonDic);
             if([[jsonDic objectForKey:@"data"]count]==0)
                 return;
             
             [self.chatArray addObjectsFromArray:[jsonDic objectForKey:@"data"]];
             
             if([[NSUserDefaults standardUserDefaults] objectForKey:@"chat"]){
                 NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults] objectForKey:@"chat"] mutableCopy];
                 [dic setObject:self.chatArray forKey:[self.personDic valueForKey:@"pkid"]];
                 [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"chat"];
             }else{
                 [[NSUserDefaults standardUserDefaults] setObject:@{[self.personDic valueForKey:@"pkid"]:self.chatArray} forKey:@"chat"];
             }
//             NSMutableDictionary *dic = [[[NSUserDefaults standardUserDefaults]objectForKey:@"room"]mutableCopy];
//             [dic setValue:[[jsonDic objectForKey:@"data"] valueForKey:@"message"] forKey:@"last_message"];
//             [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"room"];
            [self.m_tableView reloadData];

         }
    }];
//    });
}

@end
