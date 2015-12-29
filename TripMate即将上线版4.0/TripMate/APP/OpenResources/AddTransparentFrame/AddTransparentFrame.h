//
//  AddTransparentFrame.h
//  天气1.0
//
//  Created by lanou on 15/11/12.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AddTransparentFrame : NSObject

+(instancetype)shareManage;

  //添加透明框架
-(UILabel *)addTransparentFrameWithFrame:(CGRect)frame;

@end
