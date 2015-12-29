//
//  PicModel.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic,strong) NSNumber *type;

@property (nonatomic, strong) NSString *cityID;

@property (nonatomic, strong) NSMutableArray *picUrlArr;

@end
