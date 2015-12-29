//
//  hotelViewCell.m
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "hotelViewCell.h"
#import "UIImageView+WebCache.h"
#import "AddTransparentFrame.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation hotelViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化食品相框
        self.foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREENWIDTH, SCREENHEIGHT / 3 - 10)];
        [self.contentView addSubview:self.foodImageView];
        
        //初始化店名
        self.foodlNameView = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/30,SCREENHEIGHT/100,SCREENWIDTH,SCREENHEIGHT/15)];

        self.foodlNameView.numberOfLines = 2;
        self.foodlNameView.font = [UIFont systemFontOfSize:SCREENHEIGHT/30];
        self.foodlNameView.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.foodlNameView];
        
        //初始化时间
        self.foodDateView = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/30,SCREENHEIGHT/4,SCREENWIDTH,SCREENHEIGHT/15)];
        self.foodDateView.font = [UIFont systemFontOfSize:SCREENHEIGHT/35];
        self.foodDateView.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.foodDateView];
    }
    return self;
}


//赋值

-(void)setHt:(hotel *)ht{
    
    _ht = ht;
    
    //下载图片并赋值
    NSURL * url = [NSURL URLWithString:ht.cover_route_map_cover];
//    [self.foodImageView sd_setImageWithURL:url];
    [self.foodImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    
    
    self.foodlNameView.text = ht.name;
    self.foodDateView.text = ht.date_added;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
