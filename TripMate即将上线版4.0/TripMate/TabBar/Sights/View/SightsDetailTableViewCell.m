//
//  SightsDetailTableViewCell.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "SightsDetailTableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation SightsDetailTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 80, 30)];
        self.label.backgroundColor = [UIColor blackColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:17 weight:1];
        [self.contentView addSubview:self.label];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 42, kScreenWidth - 10, 30)];
        self.label1.backgroundColor = [UIColor whiteColor];
        self.label1.font = [UIFont systemFontOfSize:16];
        self.label1.numberOfLines = 0;
        [self.contentView addSubview:self.label1];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label1.frame = CGRectMake(5,42, self.contentView.frame.size.width - 10, self.contentView.frame.size.height - 42);
}

@end
