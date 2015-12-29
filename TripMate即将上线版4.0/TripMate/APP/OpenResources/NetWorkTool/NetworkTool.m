//
//  NetworkTool.m
//  UI_lesson_KVO实现cell的图片异步下载
//
//  Created by lanou on 15/10/14.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "NetworkTool.h"

@interface NetworkTool ()

@property (retain, nonatomic) NSURLSessionDataTask *dataTask;

@property (retain, nonatomic) NSMutableData *mData;
@end




@implementation NetworkTool

- (instancetype) initWithURLStr:(NSString *)urlStr delegate:(id<NetWorkToolDelegate>)delegate;
{
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        self.dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlStr]];
        
        self.mData = [NSMutableData data];
        self.delegate = delegate;
    }
    return self;
}



-(void)startTask
{
    [self.dataTask resume];
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.mData appendData:data];
}


//  下载完成的协议方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    id result = [NSJSONSerialization JSONObjectWithData:self.mData options:NSJSONReadingMutableContainers error:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(networkResult:)]) {
        [self.delegate networkResult:result];
    }
}



@end
