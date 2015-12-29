//
//  foodDetailViewController.h
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>
@class food;
@interface foodDetailViewController : UIViewController

@property (nonatomic,strong)food *fd;

@property (nonatomic,strong) NSString * headStr;

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *ID;

@end
