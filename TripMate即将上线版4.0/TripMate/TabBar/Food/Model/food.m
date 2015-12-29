//
//  food.m
//  01-美食
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 周恩培. All rights reserved.
//

#import "food.h"

@implementation food

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
