//
//  hotel.m
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "hotel.h"

@implementation hotel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    self.description1 = dict[@"description"];
    
    self.HotelID = dict[@"id"];
    self.HotelType = dict[@"type"];
    
    return self;
}
+ (instancetype)foodWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
