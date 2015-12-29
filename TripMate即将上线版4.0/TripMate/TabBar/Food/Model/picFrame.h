//
//  picFrame.h
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "pic.h"

@interface picFrame : NSObject

/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconF;
/**
 *  昵称的frame
 */
@property (nonatomic, assign, readonly) CGRect trip_nameF;
/**
 *  会员图标的frame
 */
@property (nonatomic, assign, readonly) CGRect description2F;
/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  配图的frame
 */
@property (nonatomic, assign, readonly) CGRect photo_sF;

/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@property (nonatomic, assign, readonly) CGRect  opening_timeF;

@property (nonatomic ,assign, readonly) CGRect feeF;

@property (nonatomic, strong) pic *pc;


@end
