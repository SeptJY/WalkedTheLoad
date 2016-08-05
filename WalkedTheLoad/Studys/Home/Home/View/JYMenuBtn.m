//
//  JYMenuBtn.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/4.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYMenuBtn.h"

@implementation JYMenuBtn

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.width = 20;
    self.imageView.height = 20;
    self.imageView.x = 8;
    self.imageView.y = 10;
    
    // 调整文字
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 8;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width - self.titleLabel.x;
    self.titleLabel.height = self.height;
}

@end
