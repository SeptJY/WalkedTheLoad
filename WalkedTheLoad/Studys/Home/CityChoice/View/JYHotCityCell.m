//
//  JYHotCityCell.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYHotCityCell.h"

const static NSInteger margin = 10;
const static NSInteger space = 15;

@interface JYHotCityCell ()

@property (nonatomic, strong) NSArray *hotCitys;

@end

@implementation JYHotCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView ddentifier:(NSString *)ID hotCity:(NSArray *)hotCity
{
    JYHotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JYHotCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID hotCity:hotCity];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hotCity:(NSArray *)hotCity
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.hotCitys = hotCity;
        
        CGFloat btnW = (screenW - 3 * space - 2 * margin) / 3;
        CGFloat btnH = 35;
        int totalColumns = 3;
        
        for (int i = 0; i < hotCity.count; i ++) {
            
            int row = i / totalColumns;
            int col = i % totalColumns;
            
            // 计算x和y
            CGFloat btnX = space + col * (btnW + margin);
            CGFloat btnY = 5 + row * (btnH + margin);
            
            UIButton *btn = [[UIButton alloc] init];
            
            [btn setTitle:hotCity[i] forState:UIControlStateNormal];
            btn.titleLabel.font = setFont(15);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 4;
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
            
            [btn addTarget:self action:@selector(hotCityBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            // 设置frame
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            [self.contentView addSubview:btn];
        }
        
        CGFloat selfHight = (self.hotCitys.count / 3 == 0) ? (self.hotCitys.count / 3 * btnH + 10 * (self.hotCitys.count / 3 + 1)) : ((self.hotCitys.count / 3 + 1) * btnH + 10 * (self.hotCitys.count / 3 + 2));
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, selfHight - 0.5, screenW, 0.5)];
        
        lineView.backgroundColor = setColor(214, 214, 214);
        
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)hotCityBtnOnClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotCityBtnTitle:)]) {
        [self.delegate hotCityBtnTitle:btn.currentTitle];
    }
}

@end
