//
//  JYMineCell.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/10.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYMineCell.h"

@implementation JYMineCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"mine";
    JYMineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JYMineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        
    }
    return self;
}

#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
    
    self.imageView.size = CGSizeMake(20, 20);
    self.imageView.y = (self.height - self.imageView.height) / 2;
    
    self.textLabel.x = self.imageView.x + self.imageView.width + 10;
}

@end
