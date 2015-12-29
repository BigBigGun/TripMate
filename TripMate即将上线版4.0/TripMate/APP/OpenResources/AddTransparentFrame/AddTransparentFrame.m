//
//  AddTransparentFrame.m
//  天气1.0
//
//  Created by lanou on 15/11/12.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "AddTransparentFrame.h"

@implementation AddTransparentFrame

+(instancetype)shareManage{
    static AddTransparentFrame  *add = nil;
    
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        add = [[AddTransparentFrame alloc] init];
        

    });
    
    
    
    return add;
    
}


-(UILabel *)addTransparentFrameWithFrame:(CGRect)frame{
    
    
    UILabel *label =[[UILabel alloc] initWithFrame:frame];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.alpha=0.7;
    
    return label;
    
}





@end
