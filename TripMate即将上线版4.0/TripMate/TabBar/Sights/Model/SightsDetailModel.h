//
//  SightsDetailModel.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SightsDetailModel : NSObject

//description
//arrival_type
//photo_count
//opening_time
//name
//address

@property (nonatomic,strong) NSString *description1;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *arrival_type;

@property (nonatomic, strong) NSString *opening_time;

@property (nonatomic, strong) NSNumber *photo_count;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *photoURL;

@property (nonatomic, strong) NSMutableArray *photoArr;

@property (nonatomic, strong) NSString *recommended_reason;
@end
