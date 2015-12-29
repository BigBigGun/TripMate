//
//  HotelPicViewCell.h
//  Trip
//
//  Created by lanou on 15/11/14.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotelFrame.h"

@interface HotelPicViewCell : UITableViewCell

@property (nonatomic ,strong) hotelFrame * hotelF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
