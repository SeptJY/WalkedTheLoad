//
//  JYScanBgView.m
//  JYTest
//
//  Created by Sept on 16/7/26.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYScanBgView.h"


const static NSInteger magrin = 50;  // 距离主视图边界
#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height
#define space (screenW - 2 * magrin)    // 二维码扫描框大小
#define erWerCodeY (screenH * 0.5 - space * 2 / 3)  // 二维码框的Y值

@interface JYScanBgView ()

@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation JYScanBgView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 创建一个扫描动画
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_icon"]];
        self.imgView.frame = CGRectMake(magrin, erWerCodeY + 10, space, 3);
        
        [self addSubview:self.imgView];
        
        [self imgViewAnimation];
    }
    return self;
}

/** 扫描线条动画 */
- (void)imgViewAnimation
{
    CGRect frame = CGRectMake(magrin, erWerCodeY + 10 + space - 30, space, 3);
    
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut animations:^{
        self.imgView.frame = frame;
    } completion:nil];
}

- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *mColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    CGContextSetFillColorWithColor(ctx, mColor.CGColor);//填充颜色
    //顶部矩形
    CGFloat topH = (int)erWerCodeY;
    CGContextFillRect(ctx, CGRectMake(0, 0, screenW, topH));
    
    //画左边矩形
    CGFloat leftW = magrin;
    CGContextFillRect(ctx, CGRectMake(0, topH, leftW, screenH - topH));
    
    //画右边矩形
    CGContextFillRect(ctx, CGRectMake(screenW - leftW, topH, leftW, screenH - topH));
    
    //画底部矩形
    CGFloat bottomY = topH + space;
    CGContextFillRect(ctx, CGRectMake(leftW, bottomY, space, screenH - bottomY));
    
    self.cornerColor = (self.cornerColor == nil) ? [UIColor colorWithRed:15/255.0 green:209/255.0 blue:27/255.0 alpha:1] : self.cornerColor;
    CGContextSetFillColorWithColor(ctx, self.cornerColor.CGColor);//填充颜色
    CGFloat smallH = 2;
    CGFloat smallW = 15;
    // 左上角
    CGContextFillRect(ctx, CGRectMake(magrin, topH, smallW, smallH));
    CGContextFillRect(ctx, CGRectMake(magrin, topH, smallH, smallW));
    
    // 右上角
    CGContextFillRect(ctx, CGRectMake(screenW - smallW - magrin, topH, smallW, smallH));
    CGContextFillRect(ctx, CGRectMake(screenW - smallH - magrin, topH, smallH, smallW));
    
    // 左下角
    CGContextFillRect(ctx, CGRectMake(magrin, bottomY - smallH, smallW, smallH));
    CGContextFillRect(ctx, CGRectMake(magrin, bottomY - smallW, smallH, smallW));
    
    // 右下角
    CGContextFillRect(ctx, CGRectMake(screenW - smallW - magrin, bottomY - smallH, smallW, smallH));
    CGContextFillRect(ctx, CGRectMake(screenW - smallH - magrin, bottomY - smallW, smallH, smallW));
    
    UIColor *bColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(ctx, bColor.CGColor);//填充颜色
    
    // 边框线条
    CGFloat leftX = magrin + smallW;
    CGFloat lingH = 0.5;
    CGFloat lingW = space - smallW * 2;
    
    // 顶部
    CGContextFillRect(ctx, CGRectMake(leftX, topH + lingH, lingW, lingH));
    
    // 底部
    CGContextFillRect(ctx, CGRectMake(leftX, bottomY - 2 * lingH, lingW, lingH));
    
    // 左边
    CGContextFillRect(ctx, CGRectMake(magrin + lingH, topH + smallW, lingH, lingW));
    
    // 右边
    CGContextFillRect(ctx, CGRectMake(screenW - 2 * lingH - magrin , topH + smallW, lingH, lingW));
    
    // 文字
    NSString *text = @"将二维码/条形码放入框内，即可自动扫描";
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    NSDictionary *dict  =@{NSFontAttributeName:font, NSForegroundColorAttributeName : [UIColor whiteColor]};
    CGSize textSize = [NSString sizeWithText:text font:font maxSize:CGSizeMake(screenW, 100)];
    [text drawInRect:CGRectMake((screenW - textSize.width) * 0.5, space + erWerCodeY + 20, textSize.width, textSize.height) withAttributes:dict];
    
    CGContextStrokePath(ctx);
}

@end
