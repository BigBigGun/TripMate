//
//  food.h
//  01-美食
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 周恩培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface food : NSObject

@property (nonatomic,strong)NSString *date_added;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *cover_route_map_cover;
@property (nonatomic,strong)NSString *description1;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *type;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)foodWithDict:(NSDictionary *)dict;
@end
