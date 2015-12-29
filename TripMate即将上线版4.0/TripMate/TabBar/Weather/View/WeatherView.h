//
//  WeatherView.h
//  天气1.0
//
//  Created by lanou on 15/11/10.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherForecastModel.h"
@interface WeatherView : NSObject

@property(nonatomic, strong)UIView *weatherView;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)UILabel *wenduSizeLabel;//温度区间
@property(nonatomic, strong)UILabel *typeLabel;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)WeatherForecastModel *weatherModel;


//初始化
-(instancetype)initWithFrame:(CGRect)frame;
//给View赋值


@end
