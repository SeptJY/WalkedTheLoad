//
//  JYLocationCell.h
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYLocationCellDelegate <NSObject>

@optional
- (void)locationCityBtnOnClick:(NSString *)city;

@end

@interface JYLocationCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)ID;

@property (weak, nonatomic) id<JYLocationCellDelegate> delegate;

@end
