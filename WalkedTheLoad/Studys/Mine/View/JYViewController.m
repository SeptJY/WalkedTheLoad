//
//  JYViewController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/11.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYViewController.h"
#import "JYShowErWeiCode.h"

#pragma mark  -------- JYShadeView
@implementation JYShadeView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([JYShowErWeiCode sharedInstance].shadeBgColor == ShadeBackgroundSolid) {
        [[UIColor colorWithWhite:0 alpha:0.55] set];
        CGContextFillRect(context, self.bounds);
    } else {
        CGContextSaveGState(context);
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0, 0, 0, 0.3, 0, 0, 0, 0.8};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace), colorSpace = NULL;
        CGPoint gradCenter= CGPointMake(round(CGRectGetMidX(self.bounds)), round(CGRectGetMidY(self.bounds)));
        CGFloat gradRadius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        CGContextDrawRadialGradient(context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient), gradient = NULL;
        CGContextRestoreGState(context);
    }
}

@end

#pragma mark  -------- JYViewController
@interface JYViewController ()


@end

@implementation JYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([JYShowErWeiCode sharedInstance].tapOutsideToDismiss) {
        [[JYShowErWeiCode sharedInstance] hideAnimated:YES withCompletionBlock:nil];
    }
}

- (JYShadeView *)shadeView
{
    if (!_shadeView) {
        
        _shadeView = [[JYShadeView alloc] init];
        
        _shadeView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _shadeView.opaque = NO;
        
        [self.view addSubview:_shadeView];
    }
    return _shadeView;
}

- (void)viewDidLayoutSubviews
{
    self.shadeView.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
