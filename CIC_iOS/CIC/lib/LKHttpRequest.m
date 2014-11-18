//
//  LKHttpRequest.m
//  CIC
//
//  Created by GiPyeong Lee on 2014. 11. 5..
//  Copyright (c) 2014년 com.devsfolder.cic. All rights reserved.
//  English Name is Luke
//  Contact with me devsfolder@gmail.com

#import "LKHttpRequest.h"
#import "LKProgressView.h"
#import "Define.h"
#import "UIColor+FlatUI.h"
@interface LKHttpRequest() <NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate,LKProgressDelegate>
{
    
}
@property (nonatomic,strong) NSMutableDictionary *responsesData;
@property (nonatomic,strong) LKProgressView *progressView;
@property (nonatomic,strong) NSURLSession *session;

@end

@implementation LKHttpRequest
@synthesize delegate;
- (id)init{
    self = [super init];
    if(self){
        self.responsesData = @{}.mutableCopy;
        NSURLSessionConfiguration *sessionConfig =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.URLCache = [NSURLCache sharedURLCache]; // NEW LINE ON TOP OF OTHERWISE WORKING CODE
        sessionConfig.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        self.progressView = [[LKProgressView alloc]init];
        [self.progressView setDelegate:self];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        
    }
    return self;
}
#pragma mark - Download

- (void)downloadDataWithURL:(NSURL *)url comlete:(complete)completeBlock{
    NSLog(@"%s",__FUNCTION__);
    NSURLSessionDataTask *downloadTask = [self.session
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              completeBlock(data);
                                          }];
    [downloadTask resume];
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

- (void)uploadDataWithURL:(NSString *)url withParams:(NSDictionary *)param withImage:(NSData *)imageData{
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"%s",__FUNCTION__);
    
//    NSMutableString *paramStr = @"".mutableCopy;
//    if(param!=nil){
//        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//            [paramStr appendFormat:@"%@=%@",key,obj];
//            [paramStr appendString:@"&"];
//        }];
//        [urlRequest setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    [urlRequest addValue:@"" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n",sharedUserInfo(@"pkid")] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter UserId
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[sharedUserInfo(@"pkid") dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [urlRequest setHTTPBody:body];
    
    ///
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithStreamedRequest:urlRequest];
    
    
    [uploadTask resume];
    // progressview 활성화
    [self.progressView showProgressView];
}



#pragma mark - NSURLSessionTaskDelegate methods

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%lf",(double)totalBytesSent);
        [self.progressView.progress setProgress:
         (double)totalBytesSent /
         (double)totalBytesExpectedToSend animated:YES];
        [self.progressView.progressLabel setText:[NSString stringWithFormat:@"%.1f%%",(double)totalBytesSent /
                                                  (double)totalBytesExpectedToSend*100]];
    });
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *responseData = self.responsesData[@(dataTask.taskIdentifier)];
    if (!responseData) {
        responseData = [NSMutableData dataWithData:data];
        self.responsesData[@(dataTask.taskIdentifier)] = responseData;
    } else {
        [responseData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 1
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //
    //        [self.progressView hideProgressView];
    //    });
    if (error) {
        NSLog(@"%@ failed: %@", task.originalRequest.URL, error);
    }
    
    NSMutableData *responseData = self.responsesData[@(task.taskIdentifier)];
    
    // my response is JSON; I don't know what yours is, though this handles both
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    if (response) {
        NSLog(@"response = %@", response);
    } else {
        if(responseData!=nil)
        NSLog(@"responseData = %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    }
    
    [self.responsesData removeObjectForKey:@(task.taskIdentifier)];

    if (!error) {
        // 2
        
        [self.progressView.progressLabel setText:@"DONE"];
        [self.progressView.progress setProgressTintColor:[UIColor emerlandColor]];
        [self.progressView hideProgressView];
        [delegate finishUploadData];
        
    } else {
        [self.progressView.progressLabel setText:@"FAIL"];
        [self.progressView hideProgressView];
        // Alert for error
    }
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

#pragma mark - LKProgressViewDelegate

- (void)cancelRequest{
    [self.session finishTasksAndInvalidate];
    
}

@end
