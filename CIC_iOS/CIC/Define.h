//
//  Define.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 9..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#ifndef CIC_Define_h
#define CIC_Define_h

#pragma mark - LOAD VIEW CONTROLLER FROM STORYBOARD
#define sharedUserInfo(key) [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]valueForKey:key]
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]
#define VIEWCONTROLLER(name) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:name]
#define IMAGE(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",name]]

#pragma mark - HTTP REQUEST STATUS CODE
#define kREQUEST_SUCCESS @"200"
#define kREQUEST_FAIL @"400"

#pragma mark - URL FLAGS
#define kURL_MEMBER_LOGIN @"https://cic.hongik.ac.kr/api/login.php"
#define kURL_MEMBER_JOIN @"https://cic.hongik.ac.kr/api/join.php"

#endif
