//
//  picViewCell.m
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "picViewCell.h"
#import "pic.h"
#import "UIImageView+WebCache.h"
#define MJNameFont [UIFont systemFontOfSize:12]
// 正文的字体
#define MJTextFont [UIFont systemFontOfSize:15]

@interface picViewCell()
/**
 *  头像
 */
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


@implementation picViewCell

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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

/**
 *  在这个方法中设置子控件的frame和显示数据
 */
- (void)setPicF:(picFrame *)picF
{
    _picF = picF;
    
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
    pic *pc = self.picF.pc;
    
    // 1.头像
    NSURL *url = [NSURL URLWithString:pc.icon];
    
    UIImage * placeHold = [UIImage imageNamed:@"placeholder.jpeg"];
   [self.iconView sd_setImageWithURL:url placeholderImage:placeHold];

    self.nameView.text = pc.trip_name;
    
    self.textView.text = pc.text;
    
    self.openView.text = pc.opening_time;
//
//    // 5.配图
    if (pc.photo_s) { // 有配图
        self.pictureView.hidden = NO;
        NSURL *pcUrl = [NSURL URLWithString:pc.photo_s];
        [self.pictureView sd_setImageWithURL:pcUrl placeholderImage:placeHold];
        
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
    self.iconView.frame = self.picF.iconF;
    
    // 2.昵称
    self.nameView.frame = self.picF.trip_nameF;
    
    // 3.会员图标
    self.openView.frame = self.picF.opening_timeF;
    
    // 4.正文
    self.textView.frame = self.picF.textF;
    
    // 5.配图
    if (self.picF.pc.photo_s) {// 有配图
        self.pictureView.frame = self.picF.photo_sF;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    picViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[picViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
