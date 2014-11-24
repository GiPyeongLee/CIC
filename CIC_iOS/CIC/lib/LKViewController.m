//
//  LKViewController.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 6..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "LKViewController.h"
#import "LKSideViewController.h"
@interface LKViewController () <UITextFieldDelegate,UIAlertViewDelegate>
{
    BOOL isKeyboardAnimating;
    UIDatePicker *activeDatePicker;
}

@end

@implementation LKViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    isKeyboardAnimating = false;
    NSLog(@"%s",__FUNCTION__);
    // 키보드 상태 변경 체크
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillChange:(NSNotification *)notification{
    NSLog(@"%s",__FUNCTION__);
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];


    [UIView beginAnimations:@"keyboardAnimate" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    
    newFrame.size.height -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    
    self.view.frame = newFrame;
    
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    [UIView commitAnimations];
    //    [UIView animateWithDuration:animationDuration animations:^{
    //        [UIView setAnimationCurve:animationCurve];
    //        CGRect newFrame = self.view.frame;
    //        CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    //        CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    //
    //        newFrame.size.height -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    //        self.view.frame = newFrame;
    //    } completion:^(BOOL finished) {
    //        [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y, self.scrollView.frame.size.width, self.view.frame.size.height) animated:true];
    //
    //    }];
    
    //    scrollFrame.origin.y += (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    //    scrollFrame.size.height -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    //    self.scrollView.frame = scrollFrame;
    //    [self.scrollView setContentSize:self.view.frame.size];
    
    //    NSDictionary* info = [notification userInfo];
    //    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [info objectForKey: UIKeyboardAnimationCurveUserInfoKey];
    //    CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat gap = 50.f;
    //    //352 ,216
    //    // 568
    //    goalFrame = CGRectMake(0, 0,self.view.frame.size.width, kKeyBoardFrame.origin.y);
    //
    //    if(isKeyboardAnimating==false){
    //        isKeyboardAnimating = true;
    //        //        dispatch_async(dispatch_get_main_queue(), ^{
    //        [self.view setFrame:goalFrame];
    //        self.scrollView.frame=self.view.frame;
    //        [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y-gap,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:true];
    //        //        });
    //        //            [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y-gap,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:true];
    //    }else{
    //        NSLog(@"%f",goalFrame.size.height);
    //        [self.view setFrame:goalFrame];
    //        self.scrollView.frame=self.view.frame;
    //        [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y-gap,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:true];
    //
    //        //        [UIView animateWithDuration:[duration doubleValue] animations:^{
    //        //            //ANIMATE VALUES HERE
    //        //            [UIView setAnimationCurve:[curve integerValue]];
    //        //            [self.view setFrame:goalFrame];
    //        //        } completion:^(BOOL finished) {
    //        //            [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y-gap, self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:true];
    //        //        }];
    //    }
}
- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context{
    if([animationID isEqualToString:@"keyboardAnimate"]){
    [self.scrollView scrollRectToVisible:CGRectMake(0, touchFieldRect.origin.y, self.scrollView.frame.size.width, touchFieldRect.size.height+self.scrollView.frame.size.height/2) animated:true];

    }
}

#pragma mark - TextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%s",__FUNCTION__);
    touchFieldRect = textField.frame;
    
    return true;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FUIAlertView
- (void)showAlertViewWithTitle:(NSString *)title description:(NSString *)description
{
    FUIAlertView *alertView = [[FUIAlertView alloc]initWithTitle:title message:description delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    alertView.backgroundOverlay.backgroundColor = [UIColor clearColor];
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor midnightBlueColor];
    alertView.alertContainer.layer.cornerRadius = 14.0f;
    [alertView show];
}
#pragma mark - IBOutlet

- (IBAction)pushedBackBtn:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [sender setAlpha:0.0f];
    [sender setFrame:CGRectZero];
    [UIView setAnimationDuration:0.1f];
    [UIView commitAnimations];
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)pushedSideMenu:(id)sender {
    [self.sidePanelController showLeftPanelAnimated:true];
    [(LKSideViewController *)self.sidePanelController.leftPanel refreshInfo];
}

#pragma mark - Custom Methods
- (void)showDatePickerView{
    CGFloat width = self.view.frame.size.width;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet.view setBackgroundColor:[UIColor whiteColor]];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, width, 426)];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    activeDatePicker = datePicker;
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc]init];
    pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClick)];
    [barItems addObject:doneBtn];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
    [actionSheet.view addSubview:pickerDateToolbar];
    [actionSheet.view addSubview:datePicker];
    [self presentViewController:actionSheet animated:YES completion:^{
        [UIView animateWithDuration:0.5f animations:^{
            [actionSheet.view setBounds:CGRectMake(0,0, width, 470)];
            [datePicker sizeToFit];
            
        }];
    }];
}
- (NSDate *)getSelectedDate{
    if(activeDatePicker)
        return [activeDatePicker date];
    else
        return [NSDate date];
}
- (void)hideDatePickerView{
    [self dismissViewControllerAnimated:true completion:^{
        activeDatePicker = nil;
    }];
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
