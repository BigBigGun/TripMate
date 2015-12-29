//
//  WeatherForecastViewController.h
//  天气1.0
//
//  Created by lanou on 15/11/9.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface WeatherForecastViewController : UIViewController



@property (nonatomic, strong)UILabel *cityLabel;
@property (nonatomic, strong)UILabel *wenduLabel;
@property (nonatomic, strong)UILabel *typeLabel;
@property (nonatomic, strong)UILabel *fengliLabel;
@property (nonatomic, strong)UILabel *fengxiangLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *ganmaoLabel;

@property (nonatomic, strong)UIImageView *backgrondImageView;//背景图片
@property (nonatomic, strong)UIView *wenduView;//显示温度的那个大View
@property (nonatomic, strong)UIView *weatherView;//滚动图里面的View


@property (nonatomic, strong)UIScrollView *weatherScrollView;
@property (nonatomic, strong)UITableView *weatherTableView;



@end
