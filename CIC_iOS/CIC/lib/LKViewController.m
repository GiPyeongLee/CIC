//
//  LKViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 6..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"

@interface LKViewController () <UITextFieldDelegate>
{
    BOOL isKeyboardAnimating;
    CGRect touchFieldRect;
}
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@end

@implementation LKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isKeyboardAnimating = false;
    // 키보드 상태 변경 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardWillShow:(NSNotification*)notification{
    
    if(isKeyboardAnimating==false){
        isKeyboardAnimating = true;

        NSDictionary* info = [notification userInfo];
        NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [info objectForKey: UIKeyboardAnimationCurveUserInfoKey];
        CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat gap = 50.f;
        //352 ,216
        // 568
        CGSize scrollViewContentSize = self.view.frame.size;
        [UIView animateWithDuration:[duration doubleValue] animations:^{
            //ANIMATE VALUES HERE
            [UIView setAnimationCurve:[curve integerValue]];
            [self.view setFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height-kKeyBoardFrame.size.height)];
        } completion:^(BOOL finished) {
            [self.scrollView setContentSize:scrollViewContentSize];
            [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y-gap, self.view.frame.size.width, self.view.frame.size.height) animated:true];
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)notification{
    if(isKeyboardAnimating==true){
        isKeyboardAnimating = false;
        NSDictionary* info = [notification userInfo];
        NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [info objectForKey: UIKeyboardAnimationCurveUserInfoKey];
        CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect goalRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + kKeyBoardFrame.size.height);
        
        [self.scrollView setFrame:goalRect];

        [UIView animateWithDuration:[duration doubleValue] animations:^{
            //ANIMATE VALUES HERE
            [UIView setAnimationCurve:[curve integerValue]];
            [self.view setFrame:CGRectMake(0, 0,self.view.frame.size.width, goalRect.size.height)];

        } completion:^(BOOL finished) {

        }];
    }
}

#pragma mark - TextField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    touchFieldRect = textField.frame;
    return true;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
