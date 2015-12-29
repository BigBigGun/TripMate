//
//  picFrame.m
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "picFrame.h"

#define MJNameFont [UIFont systemFontOfSize:12]
// 正文的字体
#define MJTextFont [UIFont systemFontOfSize:SCREENHEIGHT/30]

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation picFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)setPc:(pic *)pc
{
    _pc = pc;
    
    // 子控件之间的间距
    CGFloat padding = 10;
    
    // 1.头像
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = SCREENWIDTH/15;
    CGFloat iconH = SCREENWIDTH/15;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    // 文字的字体
    CGSize nameSize = [self sizeWithText:self.pc.trip_name font:MJNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameX = CGRectGetMaxX(_iconF) + padding;
    CGFloat nameY = iconY + (iconH - nameSize.height) * 0.5;
    _trip_nameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);

  
        CGFloat pictureX = nameX;
        CGFloat pictureY = CGRectGetMaxY(_trip_nameF) + padding;
        CGFloat pictureW = SCREENWIDTH/3;
        CGFloat pictureH = SCREENWIDTH/3;
        _photo_sF = CGRectMake(pictureX, pictureY, pictureW, pictureH);

    CGFloat textX = pictureX;
    CGFloat textY = CGRectGetMaxY(_photo_sF) + padding;
    CGSize textSize = [self sizeWithText:self.pc.text font:MJTextFont maxSize:CGSizeMake(SCREENWIDTH/1.2, MAXFLOAT)];
   _textF = CGRectMake(textX, textY, textSize.width, textSize.height);
   
   _cellHeight = CGRectGetMaxY(_textF) + padding;
    
 
}



@end
