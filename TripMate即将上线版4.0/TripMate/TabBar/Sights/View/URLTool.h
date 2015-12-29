//
//  URLTool.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLTool : NSObject

@property (nonatomic) NSInteger flag;

+ (instancetype) shareURLTool;

- (NSString *) picURLWithCityID:(NSString *) cityID CityStye:(NSNumber *) cityType;

- (NSString *) dataURLWithCityID:(NSString *) cityID CityStye:(NSNumber *) cityType flag:(NSInteger)flag;


@end
