//
//  mall.m
//  TripMate
//
//  Created by lanou on 15/11/17.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "mall.h"

@implementation mall

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    self.description1 = dict[@"description"];
    
    self.ID = dict[@"id"];
    self.type = dict[@"type"];
    
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
