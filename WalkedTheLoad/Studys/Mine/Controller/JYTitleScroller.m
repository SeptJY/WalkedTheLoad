//
//  JYTitleScroller.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/9.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYTitleScroller.h"

@interface JYTitleScroller ()

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UIScrollView *scroller;

@property (strong, nonatomic) UIButton *lastBtn;

@end

@implementation JYTitleScroller

+ (instancetype)titleScrollerWithArray:(NSArray *)titleArray
{
    return [[self alloc] initWithArray:titleArray];
}

- (instancetype)initWithArray:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        
        self.titleArray = titleArray;
        
        for (int i = 0; i < self.titleArray.count; i ++) {
            
            CGSize btnSize = [NSString sizeWithText:self.titleArray[i] font:setBoldFont(15) maxSize:CGSizeMake(200, 50)];
            CGFloat btnW = btnSize.width + 30;
            
//            NSLog(@"%f", self.totalX);
            CGFloat btnX = (i == 0) ? 10 : CGRectGetMaxX(self.lastBtn.frame);
            
            UIButton *btn = [[UIButton alloc] init];
            
            btn.frame = CGRectMake(btnX, 0, btnW, 45);
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = setBoldFont(15);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:btn];
            self.lastBtn = btn;
        }
        
        self.scroller.contentSize = CGSizeMake(2000, 0);
        
    }
    return self;
}

- (UIScrollView *)scroller
{
    if (!_scroller) {
        
        _scroller = [[UIScrollView alloc] init];
//        _scroller.showsVerticalScrollIndicator = NO;
//        _scroller.showsHorizontalScrollIndicator = NO;
        
        _scroller.bounces = NO;
        _scroller.backgroundColor = [UIColor cyanColor];
        
        [self insertSubview:_scroller atIndex:0];
    }
    return _scroller;
}

- (void)layoutSubviews
{
    self.scroller.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
