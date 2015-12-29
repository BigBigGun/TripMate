//
//  HotelDetailsViewController.h
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>
@class hotel;

@interface HotelDetailsViewController : UIViewController

@property (nonatomic ,strong)hotel *ht ;

@property (nonatomic,strong) NSString * headStr;

@property (nonatomic,strong) NSString * HotelType;

@property (nonatomic,strong) NSString * HotelID;

@end
