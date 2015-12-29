//
//  SightsTableViewCell.h
//  Trip
//
//  Created by 陆俊伟 on 15/11/10.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SightsModel.h"

@interface SightsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cover_sImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommandLabel;
@property (weak, nonatomic) IBOutlet UILabel *visited_countLabel;
@property (strong, nonatomic) SightsModel *model;

@end
