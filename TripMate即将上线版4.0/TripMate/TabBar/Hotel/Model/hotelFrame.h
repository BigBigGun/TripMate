//
//  hotelFrame.h
//  Trip
//
//  Created by lanou on 15/11/14.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "hotelPic.h"


@interface hotelFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect trip_nameF;
@property (nonatomic, assign, readonly) CGRect description2F;
@property (nonatomic, assign, readonly) CGRect textF;
@property (nonatomic, assign, readonly) CGRect photo_sF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign, readonly) CGRect  opening_timeF;
@property (nonatomic ,assign, readonly) CGRect feeF;
@property (nonatomic, strong) hotelPic *hotelPc;

@end
