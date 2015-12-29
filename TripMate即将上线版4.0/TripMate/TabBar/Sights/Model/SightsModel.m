//
//  SightsModel.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "SightsModel.h"

@implementation SightsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}


- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.placeID = value;
    }
}
@end
