//
//  UIImage+Async.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 14..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Async)

+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
