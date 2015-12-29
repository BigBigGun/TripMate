//
//  SlideMenuViewController.h
//  LRLayoutDemo
//
//  Created by LiYeBiao on 15/4/14.
//  Copyright (c) 2015年 GaoJing Electric Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Slide_iScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define Slide_iScreenHeight ([UIScreen mainScreen].bounds.size.height)

@protocol SlideMenuViewControllerDelegate <NSObject>

@optional
- (void) backSights:(NSString *)cityID type:(NSNumber *)type;

- (void) backFoods:(NSString *)cityID type:(NSNumber *)type;

- (void) backHotels:(NSString *)cityID type:(NSNumber *)type;
- (void) backMalls:(NSString *)cityID type:(NSNumber *)type;

- (void) backSights;

- (void) recover;

@end


@interface SlideMenuViewController : UIViewController

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,copy) void (^menuClickBlock)(UIViewController * controller);

@property (nonatomic, weak) id<SlideMenuViewControllerDelegate> delegate;

@property (nonatomic, weak) id<SlideMenuViewControllerDelegate> delegate1;

@property (nonatomic, weak) id<SlideMenuViewControllerDelegate> delegate2;
//食物
@property (nonatomic, weak) id<SlideMenuViewControllerDelegate> delegate3;

@property (nonatomic, weak) id<SlideMenuViewControllerDelegate> delegate4;
//- (instancetype) initWithContentViewController:(UIViewController *)contentViewController;
@end
