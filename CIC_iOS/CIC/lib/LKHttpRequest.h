//
//  LKHttpRequest.h
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//

#import <Foundation/Foundation.h>

//Block Define
typedef void (^postComplete)(NSData *data, NSURLResponse *response, NSError *error);


@interface LKHttpRequest : NSObject
- (void)postWithURL:(NSString *)url withParams:(NSDictionary *)param compelete:(postComplete)completeBlock;
@end
