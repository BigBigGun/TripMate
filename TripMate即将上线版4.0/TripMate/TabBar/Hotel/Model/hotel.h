//
//  hotel.h
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotel : NSObject
@property (nonatomic,strong)NSString *date_added;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *cover_route_map_cover;
@property (nonatomic,strong)NSString *description1;
@property (nonatomic,strong)NSString *HotelType;
@property (nonatomic,strong)NSString *HotelID;
@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *countryName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)foodWithDict:(NSDictionary *)dict;

@end
