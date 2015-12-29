//
//  FoodViewController.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"
@interface FoodViewController : UIViewController<SlideMenuViewControllerDelegate>

@property (nonatomic,strong) NSString *cityID;

@property (nonatomic,strong) NSString *type;

@end
