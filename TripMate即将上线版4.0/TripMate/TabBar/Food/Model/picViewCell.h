//
//  picViewCell.h
//  Trip
//
//  Created by lanou on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "picFrame.h"

@interface picViewCell : UITableViewCell
@property (nonatomic, strong) picFrame *picF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
