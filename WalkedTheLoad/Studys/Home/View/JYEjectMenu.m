//
//  JYEjectMenu.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYEjectMenu.h"

@implementation JYEjectMenu

+ (instancetype)ejectMenu
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%s, %@", __func__, NSStringFromCGRect(rect));
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


@end
