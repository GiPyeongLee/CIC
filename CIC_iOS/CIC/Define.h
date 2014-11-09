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
#define VIEWCONTROLLER(name) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:name]

#pragma mark - HTTP REQUEST STATUS CODE
#define kREQUEST_SUCCESS @"200"
#define kREQUEST_FAIL @"400"

#pragma mark - URL FLAGS
#define kURL_MEMBER_LOGIN @"https://cic.hongik.ac.kr/api/login.php"

#endif
