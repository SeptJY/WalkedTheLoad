//
//  JYEjectMenu.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYEjectMenu.h"

@interface JYEjectMenu ()

@end

@implementation JYEjectMenu

+ (instancetype)ejectMenuWithArray:(NSArray *)array
{
    return [[self alloc] initWithArray:array];
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat btnW = 100;
        CGFloat btnH = 40;
        
        for (int i = 0; i < array.count; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + i * btnH, btnW, btnH)];
            
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.tag = i + 10;
            btn.titleLabel.font = setBoldFont(15);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(ejectMenuBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            
            // 设置分割线
            if (i != 0) {
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10 + 40 * i, 100, 1)];
                
                lineView.backgroundColor = setColor(171, 171, 171);
                
                [self addSubview:lineView];
            }
        }
    }
    return self;
}

- (void)ejectMenuBtnOnClick:(UIButton *)btn
{
    NSLog(@"%@", btn.currentTitle);
    if (self.delegate && [self.delegate respondsToSelector:@selector(ejectMenuBtnOnClick:)]) {
        [self.delegate ejectMenuBtnOnClick:btn.tag];
    }
}

- (void)drawRect:(CGRect)rect
{
    // 画圆角矩形
    CGRect rectangle = CGRectMake(0, 10, rect.size.width, rect.size.height - 15);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rectangle cornerRadius:5.0f];
//    [[UIColor colorWithWhite:1.0 alpha:1.0] setFill];
    [JYMainColor setFill];
    [roundedRect fillWithBlendMode:kCGBlendModeNormal alpha:1];
    
    // 画三角形
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, rect.size.width -20, 0);  // 顶点
    CGContextAddLineToPoint(ctx, rect.size.width -20 - 6, 10);
    CGContextAddLineToPoint(ctx, rect.size.width -20 + 6, 10);
    // 关闭路径(连接起点和最后一个点)
    CGContextClosePath(ctx);
    
    [JYMainColor setFill]; //设置填充色
    
    [JYMainColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(ctx,
                      kCGPathFillStroke);//绘制路径path
}

/**
   实现办法：在一个填充矩形中在添加一个三角形
 */


@end
