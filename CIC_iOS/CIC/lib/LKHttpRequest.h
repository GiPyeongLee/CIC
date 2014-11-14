//
//  LKHttpRequest.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LKHttpRequestDelegate
@optional
- (void)finishUploadData;

@end

//Block Define
typedef void (^complete)(NSData *data);
typedef void (^postComplete)(NSData *data, NSURLResponse *response, NSError *error);


@interface LKHttpRequest : NSObject
@property (nonatomic,assign)id<LKHttpRequestDelegate>delegate;
// Download Data
- (void)downloadDataWithURL:(NSURL *)url comlete:(complete)completeBlock;
// This is just request data from url
- (void)postWithURL:(NSString *)url withParams:(NSDictionary *)param compelete:(postComplete)completeBlock;

// This is for upload photo, file.
- (void)uploadDataWithURL:(NSString *)url withParams:(NSDictionary *)param withImage:(NSData *)imageData;

- (void)cleanDictionary:(NSMutableDictionary *)dictionary;
@end
