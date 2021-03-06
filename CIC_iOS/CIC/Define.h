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
#define sharedPref(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define sharedUserInfo(key) [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]valueForKey:key]
#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]
#define VIEWCONTROLLER(name) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:name]
#define IMAGE(name) [UIImage imageNamed:name]
#define Int2Str(val) [NSString stringWithFormat:@"%i",val]

#pragma mark - HTTP REQUEST STATUS CODE
#define kREQUEST_SUCCESS @"200"
#define kREQUEST_FAIL @"400"

#pragma mark - URL FLAGS
#define kURL_MEMBER_LOGIN @"https://cic.hongik.ac.kr/api/login"
#define kURL_MEMBER_JOIN @"https://cic.hongik.ac.kr/api/join"
#define kURL_MEMBER_UPLOAD_PROFILE @"https://cic.hongik.ac.kr/api/upload_profile"
#define kURL_GREETING @"https://cic.hongik.ac.kr/api/greeting"
#define kURL_BOARD @"https://cic.hongik.ac.kr/api/board"
#define kURL_BOARD_COMMENT @"https://cic.hongik.ac.kr/api/board_comment"
#define kURL_BOARD_LIKE @"https://cic.hongik.ac.kr/api/board_like"
#define kURL_BOARD_COMMENT_WRITE @"https://cic.hongik.ac.kr/api/board_comment_write"
#define kURL_RENTAL_LIST @"https://cic.hongik.ac.kr/api/rental_list"
#define kURL_RENTAL_BOOK @"https://cic.hongik.ac.kr/api/rental_book"
#define kURL_COUNSEL_DATA @"https://cic.hongik.ac.kr/api/counsel"
#define kURL_SENDING_MESSAGE @"https://cic.hongik.ac.kr/api/sending_messages"
#define kURL_POLLING_MESSAGE @"https://cic.hongik.ac.kr/api/polling_messages"
#pragma mark - LKButtonType
typedef enum {
    LKButtonTypeWhite =0,
    LKButtonTypeWhiteRound, //1
    LKButtonTypeOrange, // 2
    LKButtonTypeOrangeRound, //3
    LKButtonTypeNavi, //4
    LKButtonTypeNaviRound, //5
    LKButtonTypeGray, //6
    LKButtonTypeGrayRound //7
} LKButtonType;
#define LKButtonColorOrange [UIColor colorWithRed:0.93 green:0.42 blue:0.13 alpha:1]
#define LKButtonColorWhite [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define LKButtonColorGray [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1]
#define LKButtonColorNavi [UIColor colorWithRed:0.22 green:0.24 blue:0.29 alpha:1]


#pragma mark - LKSegmentControlType
typedef enum {
    LKSegmentTypeIntro =0,
    LKSegmentTypeBoard,
    LKSegmentTypeRental,
    LKSegmentTypeChat
} LKSegmentControlType;

#define kLKSegIntroTitle @[@"인사말",@"소개",@"구성원"]
#define kLKSegBoardTitle @[@"공지사항",@"취업게시판",@"자유게시판",@"사진게시판"]

#define kLKSegBoardType @[@(1),@(2),@(4),@(9)]

#pragma mark - Graduation
#define LKGraduationTitles @[@"2014 졸업프로젝트",@"2013 졸업프로젝트"]
#define LKGraduationImageCovers @[@"cover_2014",@"cover_2013"]

#endif
