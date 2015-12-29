//
//  URLTool.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "URLTool.h"

#define URL @"http://api.breadtrip.com/destination/place/"
#define kCityURL(a,b) [NSString stringWithFormat:@"/pois/sights/?start=%ld&count=%ld&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",a,b]

@implementation URLTool

+ (instancetype) shareURLTool
{
    static URLTool *urlTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urlTool = [[URLTool alloc] init];
    });
    return urlTool;
}



- (NSString *) picURLWithCityID:(NSString *) cityID CityStye:(NSNumber *) cityType
{
    NSString *picUrlString;
    if ([cityType  isEqual: @(1)]) {
        NSString *pic = [URL stringByAppendingString:@"1/"];
        picUrlString = [pic stringByAppendingString:cityID];
        //        self.picString = [pic1 stringByAppendingString:kPicURL(self.flag, self.flag + 10)];
        
    }
    else if ([cityType isEqual:@(2)]){
        NSString *pic = [URL stringByAppendingString:@"2/"];
        picUrlString = [pic stringByAppendingString:cityID];
        //        self.picString = [pic1 stringByAppendingString:kPicURL(self.flag, self.flag + 10)];
    }
    else{
        
        NSString *pic = [URL stringByAppendingString:@"3/"];
        picUrlString = [pic stringByAppendingString:cityID];
        //        self.picString = [pic1 stringByAppendingString:kPicURL(self.flag, self.flag + 10)];
    }
    return picUrlString;
    
}

- (NSString *) dataURLWithCityID:(NSString *) cityID CityStye:(NSNumber *) cityType flag:(NSInteger)flag
{
    NSString *urlString;
    self.flag = flag;
    if ([cityType  isEqual: @(1)]) {
        NSString *str = [URL stringByAppendingString:@"1/"];
        NSString *str1 = [str stringByAppendingString:cityID];
        urlString = [str1 stringByAppendingString:kCityURL((long)self.flag, self.flag + 10)];
        NSLog(@"%@",urlString);
                
    }
    else if ([cityType isEqual:@(2)]){
        NSString *str = [URL stringByAppendingString:@"2/"];
        NSString *str1 = [str stringByAppendingString:cityID];
        urlString = [str1 stringByAppendingString:kCityURL((long)self.flag, self.flag + 10)];
        

    }
    else{
        NSString *str = [URL stringByAppendingString:@"3/"];
        NSString *str1 = [str stringByAppendingString:cityID];
        urlString = [str1 stringByAppendingString:kCityURL((long)self.flag, self.flag + 10)];
        
    }
    return urlString;
}


@end
