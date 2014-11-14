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
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
