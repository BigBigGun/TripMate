//
//  foodViewCell.h
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "food.h"


@interface foodViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *foodlNameView;
@property (nonatomic, strong)UIImageView *foodImageView;
@property (nonatomic, strong)food *fd;
@property (nonatomic, strong)UILabel *foodDateView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
