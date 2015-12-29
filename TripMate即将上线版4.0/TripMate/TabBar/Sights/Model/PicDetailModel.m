//
//  PicDetailModel.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "PicDetailModel.h"

@implementation PicDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (void) setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.last_id = value;
    }
}



@end
