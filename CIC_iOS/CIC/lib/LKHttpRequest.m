//
//  LKHttpRequest.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//  English Name is Luke
//  Contact with me devsfolder@gmail.com

#import "LKHttpRequest.h"

@interface LKHttpRequest() <NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (nonatomic,strong) NSURLSession *session;

@end

@implementation LKHttpRequest

- (id)init{
    self = [super init];
    if(self){
        NSURLSessionConfiguration *sessionConfig =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        
    }
    return self;
}

- (void)postWithURL:(NSString *)url withParams:(NSDictionary *)param compelete:(postComplete)completeBlock
{
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableString *paramStr = @"".mutableCopy;
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paramStr appendFormat:@"%@=%@",key,obj];
        [paramStr appendString:@"&"];
    }];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[self.session dataTaskWithRequest:urlRequest
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                         if(error == nil)
                                                         {
                                                             completeBlock(data,response,error);
                                                         }else{
                                                             NSLog(@"%s \n%@",__FUNCTION__,error);
                                                         }
                                                         
                                                     }];
    [dataTask resume];
}

#pragma mark - SSL Setup

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"cic.hongik.ac.kr"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
}

@end
