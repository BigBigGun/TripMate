//
//  WeatherForecastModel.h
//  天气
//
//  Created by lanou on 15/11/7.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherForecastModel : NSObject

@property (nonatomic, strong)NSString *fengxiang;//**风向
@property (nonatomic, strong)NSString *fengli;//**风力
@property (nonatomic, strong)NSString *high;//**最高温度
@property (nonatomic, strong)NSString *low;//**最低温度
@property (nonatomic, strong)NSString *type;//**气象类型
@property (nonatomic, strong)NSString *date;//**日期

@property (nonatomic, strong)NSString *city;//**气象
@property (nonatomic, strong)NSString *ganmao;//**感冒提醒
@property (nonatomic, strong)NSString *wendu;//实时温度


@end
