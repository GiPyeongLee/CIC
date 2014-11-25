//
//  ChatViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 25..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "ChatViewController.h"
#import "CounselSenderCell.h"
#import "CounselMyCell.h"
@interface ChatViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextView *m_textView;
@property (nonatomic,strong) NSMutableArray *chatArray;
@end
@implementation ChatViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.nav_title.text = self.title;
}
- (void)preloadData:(NSArray *)data withTitle:(NSString *)title{
    self.title = title;
    if(data!=nil)
        self.chatArray = data.mutableCopy;
    else{
        self.chatArray = @[@"길이 테스트",@"길이테스트\n길이테스트",@"길이테스트길이테스트길이테스트길이테스트길이테스트,길이테\n길\n\n\nㅇ"].mutableCopy;
    }
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
    CGRect rect = [[self.chatArray objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake(158, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    
    NSLog(@"%f",rect.size.height);
    return rect.size.height+50<50?50:rect.size.height+50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CounselMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounselMyCell"];
    cell.label_message.text = [self.chatArray objectAtIndex:indexPath.row];
    return cell;
}

@end
