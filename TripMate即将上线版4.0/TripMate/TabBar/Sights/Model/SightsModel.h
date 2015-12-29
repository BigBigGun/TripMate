//
//  SightsModel.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SightsModel : NSObject

#pragma mark--记得空值容错


@property (nonatomic, strong) NSNumber *visited_count;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *type;

//
@property (nonatomic, strong) NSString *placeID;


@property (nonatomic, strong) NSString *recommended_reason;

@property (nonatomic, strong) NSString *cover_s;

@end
