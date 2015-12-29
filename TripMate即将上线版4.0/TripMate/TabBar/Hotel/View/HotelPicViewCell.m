//
//  HotelPicViewCell.m
//  Trip
//
//  Created by lanou on 15/11/14.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "HotelPicViewCell.h"
#import "hotelPic.h"
#import "UIImageView+WebCache.h"

#define MJNameFont [UIFont systemFontOfSize:12]
// 正文的字体
#define MJTextFont [UIFont systemFontOfSize:15]

@interface HotelPicViewCell ()

@property (nonatomic, weak) UIImageView *iconView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UILabel *openView;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textView;
/**
 *  配图
 */
@property (nonatomic, weak) UIImageView *pictureView;


@end

@implementation HotelPicViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
  HotelPicViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil)
    {
        cell = [[HotelPicViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyCell"];
    }
   
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 2.昵称
        UILabel *nameView = [[UILabel alloc] init];
        nameView.font = MJNameFont;
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
        // 4.正文
        UILabel *textView = [[UILabel alloc] init];
        textView.numberOfLines = 0;
        textView.font = MJTextFont;
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 5.配图
        UIImageView *pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        
        UILabel *openView = [[UILabel alloc] init];
        openView.numberOfLines = 0;
        openView.font = MJTextFont;
        openView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:openView];
        self.openView = openView;
        
    }
    return self;

}

- (void)setHotelF:(hotelFrame *)hotelF
{
    _hotelF = hotelF;
    
    // 1.设置数据
    [self settingData];
    
    // 2.设置frame
    [self settingFrame];
}

/**
 *  设置数据
 */
- (void)settingData
{
    // 微博数据
    hotelPic *hotelPc = self.hotelF.hotelPc;
    
    // 1.头像
    NSURL *url = [NSURL URLWithString:hotelPc.icon];
//    [self.iconView sd_setImageWithURL:url];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    self.nameView.text = hotelPc.trip_name;
    
    self.textView.text = hotelPc.text;
    
    self.openView.text = hotelPc.opening_time;
    //
    //    // 5.配图
    if (hotelPc.photo_s) { // 有配图
        self.pictureView.hidden = NO;
        NSURL *pcUrl = [NSURL URLWithString:hotelPc.photo_s];
//        [self.pictureView sd_setImageWithURL:pcUrl];
        [self.pictureView sd_setImageWithURL:pcUrl placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
        
        
    } else { // 没有配图
        self.pictureView.hidden = YES;
    }
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 *  设置frame
 */
- (void)settingFrame
{
    // 1.头像
    self.iconView.frame = self.hotelF.iconF;
    
    // 2.昵称
    self.nameView.frame = self.hotelF.trip_nameF;
    
    // 3.会员图标
    self.openView.frame = self.hotelF.opening_timeF;
    
    // 4.正文
    self.textView.frame = self.hotelF.textF;
    
    // 5.配图
    if (self.hotelF.hotelPc.photo_s) {// 有配图
        self.pictureView.frame = self.hotelF.photo_sF;
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
