//
//  hotelPic.m
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "hotelPic.h"

@implementation hotelPic

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    NSDictionary * dic = dict[@"poi"];
    
    if (![dic isEqual:[NSNull null]])
    {
    
    NSString * text = dic[@"description"];
    if ([text isKindOfClass:[NSString class]])
    {
    self.description2 = text;
    }
    NSString * icon = dic[@"icon"];
    self.icon = icon;
    }
    return self;
}
+ (instancetype)picWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
