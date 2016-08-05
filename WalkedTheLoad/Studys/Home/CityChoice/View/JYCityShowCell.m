//
//  JYCityShowCell.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityShowCell.h"

@implementation JYCityShowCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)ID
{
    JYCityShowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JYCityShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, self.height - 0.5, screenW - 15, 0.5)];
        
        lineView.backgroundColor = setColor(214, 214, 214);
        
        [self.contentView addSubview:lineView];
    }
    return self;
}

@end
