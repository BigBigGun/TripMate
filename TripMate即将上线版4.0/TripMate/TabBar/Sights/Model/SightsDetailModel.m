//
//  SightsDetailModel.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "SightsDetailModel.h"

@implementation SightsDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if (!value || [value isKindOfClass:[NSNull class]]) {
        if ([key isEqualToString:@"address"]) {
            self.address = @"无";
        }
        else if ([key isEqualToString:@"arrival_type"]){
            self.arrival_type = @"无";
        }
        else if ([key isEqualToString:@"opening_time"]){
            self.opening_time = @"无";
        }
        else if ([key isEqualToString:@"recommended_reason"])
        {
            self.recommended_reason = @"!!!";
        }
    }
    if ([key isEqualToString:@"description"]) {
        self.description1 = value;
    }
    if ([key isEqualToString:@"hottest_places"]) {
        NSArray *arr = value;
        if (arr == 0) {
            return;
        }
        self.photoArr = [NSMutableArray array];
        NSDictionary *dic = arr[0];
        self.photoURL = dic[@"photo"];
        for (NSDictionary *dic in arr) {
            NSString *str = dic[@"photo"];
            [self.photoArr addObject:str];
        }
    }
}
@end
