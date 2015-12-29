//
//  mall.h
//  TripMate
//
//  Created by lanou on 15/11/17.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mall : NSObject

@property (nonatomic,strong)NSString *date_added;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *cover_route_map_cover;
@property (nonatomic,strong)NSString *description1;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *type;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)foodWithDict:(NSDictionary *)dict;
@end
