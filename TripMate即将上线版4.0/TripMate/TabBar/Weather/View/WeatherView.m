//
//  WeatherView.m
//  天气1.0
//
//  Created by lanou on 15/11/10.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "WeatherView.h"

#define WEATHERVIEW_WIDTH   self.weatherView.frame.size.width
#define WEATHERVIEW_HEIGHT  self.weatherView.frame.size.height








@implementation WeatherView


 //初始化
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super init];
    if (self) {
        
        
        self.weatherView = [[UIView alloc] initWithFrame:frame];
        
          //******
//        self.weatherView.backgroundColor = [UIColor whiteColor];
        
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WEATHERVIEW_WIDTH/6, 0,WEATHERVIEW_WIDTH/3*2 , WEATHERVIEW_HEIGHT/4)];
      
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, WEATHERVIEW_HEIGHT/3, WEATHERVIEW_WIDTH/3+WEATHERVIEW_WIDTH/10, WEATHERVIEW_WIDTH/3+WEATHERVIEW_WIDTH/10)];

        
        
        
        self.wenduSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WEATHERVIEW_WIDTH/2-WEATHERVIEW_WIDTH/5, WEATHERVIEW_HEIGHT/3+WEATHERVIEW_HEIGHT/24, WEATHERVIEW_WIDTH/2+WEATHERVIEW_WIDTH/5, WEATHERVIEW_WIDTH/4)];

        
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WEATHERVIEW_WIDTH/3*2, WEATHERVIEW_HEIGHT/4)];
        self.typeLabel.center = CGPointMake(WEATHERVIEW_WIDTH/2, WEATHERVIEW_HEIGHT/5*4);
        
       
//        self.dateLabel.backgroundColor = [UIColor blueColor];
//        self.imageView.backgroundColor = [UIColor orangeColor];
//        self.wenduSizeLabel.backgroundColor = [UIColor blueColor];
//        self.typeLabel.backgroundColor = [UIColor blueColor];
        
        [self.weatherView addSubview:self.dateLabel];
        [self.weatherView addSubview:self.imageView];
        [self.weatherView addSubview:self.wenduSizeLabel];
        [self.weatherView addSubview:self.typeLabel];
        
        
    }
    
    return self;
    
}

#pragma mark--赋值


-(void)setWeatherModel:(WeatherForecastModel *)weatherModel{
    
    _weatherModel = weatherModel;
    //剪切温度字符串
    NSString *str = [weatherModel.low substringWithRange:NSMakeRange(3, 2)];
    
    
    NSString *str1 = [str stringByAppendingString:@" ~ "];
    NSString *string = [weatherModel.high substringWithRange:NSMakeRange(3, 2)];

    NSString *str2 = [str1 stringByAppendingString:string];
    
    
        
    
    self.dateLabel.text = weatherModel.date;
        
   
    
    
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.wenduSizeLabel.text = str2;
    self.wenduSizeLabel.textAlignment = NSTextAlignmentCenter;
    self.wenduSizeLabel.font = [UIFont systemFontOfSize:12];

    
    
    
    self.typeLabel.text = weatherModel.type;
    
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    


    self.imageView.image = [UIImage imageNamed:@"weathertype.png"];
    
    
}





@end
