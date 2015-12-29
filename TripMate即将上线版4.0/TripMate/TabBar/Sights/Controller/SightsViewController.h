//
//  SightsViewController.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"


@protocol SightsViewControllerDelegate <NSObject>

- (void) menuRefresh;

@end


@interface SightsViewController : UIViewController <SlideMenuViewControllerDelegate>

//  城市ID
@property (nonatomic, strong) NSString *cityID;

@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, strong) SlideMenuViewController *menuVC;

@property (nonatomic, strong) id<SightsViewControllerDelegate> delegate;

@end
