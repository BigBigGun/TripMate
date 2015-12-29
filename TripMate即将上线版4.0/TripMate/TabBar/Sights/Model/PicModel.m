//
//  PicModel.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "PicModel.h"

@implementation PicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}


- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.cityID = value;
    }
    if ([key isEqualToString:@"hottest_places"]) {
        self.picUrlArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            NSString *picUrlStr = dic[@"photo"];
            [self.picUrlArr addObject:picUrlStr];
        }
    }
}

@end
