//
//  JYHotCityCell.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYHotCityCellDelegate <NSObject>

@optional
- (void)hotCityBtnTitle:(NSString *)cityName;

@end

@interface JYHotCityCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView ddentifier:(NSString *)ID hotCity:(NSArray *)hotCity;

@property (weak, nonatomic) id <JYHotCityCellDelegate>delegate;

@end