//
//  hotelPic.h
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotelPic : NSObject
@property (nonatomic ,strong) NSString * photo_s;
@property (nonatomic ,strong) NSString * photo_webtrip;
@property (nonatomic ,strong) NSString * trip_name;
@property (nonatomic ,strong) NSString * description2;
@property (nonatomic ,strong) NSString * name;
@property (nonatomic ,strong) NSString * recommended_reason;
@property (nonatomic ,strong) NSString * opening_time;
@property (nonatomic ,strong) NSString * text;
@property (nonatomic ,strong) NSString * icon;
@property (nonatomic ,strong) NSString * fee;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)picWithDict:(NSDictionary *)dict;

@end
