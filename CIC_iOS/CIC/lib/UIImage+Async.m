//
//  UIImage+Async.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 14..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import "UIImage+Async.h"
#import "LKHttpRequest.h"
@implementation UIImage (Async)
+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    LKHttpRequest *request = [[LKHttpRequest alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
      [request downloadDataWithURL:url comlete:^(NSData *data) {
          callback([UIImage imageWithData:data]);
      }];
    });
        // 3
}
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);// 컨텍스트 시작 옵션
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); // 현재 컨텍스트로부터 이미지 얻어옴.
    UIGraphicsEndImageContext(); // 컨텍스트 종료
    return newImage;
}
@end
