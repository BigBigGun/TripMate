//
//  NetworkTool.h
//  UI_lesson_KVO实现cell的图片异步下载
//
//  Created by lanou on 15/10/14.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkToolDelegate <NSObject>

- (void)networkResult:(id)result;

@end

@interface NetworkTool : NSObject <NSURLSessionDataDelegate>



@property (retain, nonatomic) id<NetWorkToolDelegate> delegate;

//  在初始化方法中添加网址,指定代理人
- (instancetype)initWithURLStr:(NSString *)urlStr delegate:(id<NetWorkToolDelegate>)delegate;

//  开始网路请求
- (void)startTask;

@end
