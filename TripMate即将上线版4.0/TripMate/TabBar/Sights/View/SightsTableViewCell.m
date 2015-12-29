//
//  SightsTableViewCell.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/10.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "SightsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SightsTableViewCell

- (void)setModel:(SightsModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    self.recommandLabel.text = model.recommended_reason;
//    [self.cover_sImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_s]];
    [self.cover_sImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_s] placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    
    
    self.visited_countLabel.text = [NSString stringWithFormat:@"%@ 人去过",[model.visited_count stringValue]];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
