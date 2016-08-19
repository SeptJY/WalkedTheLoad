//
//  JYShowErWeiCode.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/11.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYShowErWeiCode.h"
#import "JYViewController.h"

static NSTimeInterval const kFadeInAnimationDuration = 0.7;
static NSTimeInterval const kTransformPart1AnimationDuration = 0.3;
static NSTimeInterval const kTransformPart2AnimationDuration = 0.4;
static CGFloat const kDefaultCloseButtonPadding = 17.0f;

@interface JYShowView : UIView

@property (weak, nonatomic) CALayer *styleLayer;
@property (strong, nonatomic) UIColor *popBackgroundColor;

@end

@interface JYShowErWeiCode ()

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *contentViewController;

@property (strong, nonatomic) JYViewController *myViewCtl;

@property (strong, nonatomic) JYShowView *showView;

@property (strong, nonatomic) UIButton *closeBtn;

@end

@implementation JYShowErWeiCode

+ (JYShowErWeiCode *)sharedInstance {
    static JYShowErWeiCode *showErWeiCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showErWeiCode = [[JYShowErWeiCode alloc] init];
    });
    return showErWeiCode;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.position = JYBtnPositionLeft;
    }
    return self;
}

#pragma mark ---> 设置按钮的位置
- (void)setPosition:(JYBtnPosition)position
{
    _position = position;
    
    if (position == JYBtnPositionNone) {      // 不显示按钮
        self.closeBtn.hidden = YES;
    }
    else {           // 当按钮没设置掩藏
        self.closeBtn.hidden = NO;
        CGRect btnRect = self.closeBtn.frame;
        
        if (position == JYBtnPositionRight) {   // 当按钮的位置显示右边
            btnRect.origin.x = round(CGRectGetWidth(self.showView.frame) - kDefaultCloseButtonPadding - CGRectGetWidth(btnRect)/2);
        } else {
            btnRect.origin.x = 0;
        }
        self.closeBtn.frame = btnRect;
    }
    
}

- (void)showWithPresentView:(UIView *)presentView animated:(BOOL)animated
{
    CGFloat padding = 17;
    
    presentView.frame = (CGRect){padding, padding, presentView.bounds.size};
    
    CGRect containerViewRect = CGRectInset(presentView.bounds, -padding, -padding);
    containerViewRect.origin.x = containerViewRect.origin.y = 0;
    containerViewRect.origin.x = round(CGRectGetMidX(self.window.bounds) - CGRectGetMidX(containerViewRect));
    containerViewRect.origin.y = round(CGRectGetMidY(self.window.bounds) - CGRectGetMidY(containerViewRect));
    
    // 创建JYShowView
    self.showView = [[JYShowView alloc] init];
    
    self.showView.popBackgroundColor = self.popBackgroudColor;
    
    self.showView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.showView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    [self.showView addSubview:presentView];
    
    [self.myViewCtl.view addSubview:self.showView];
    
    // 创建关闭按钮
    self.closeBtn = [[UIButton alloc] init];
    
    if(self.position == JYBtnPositionRight){
        CGRect closeFrame = self.closeBtn.frame;
        closeFrame.origin.x = CGRectGetWidth(self.showView.bounds)-CGRectGetWidth(closeFrame);
        self.closeBtn.frame = closeFrame;
    }
    
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"red_packge_close"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:self.closeBtn];
    [self setPosition:self.position];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window makeKeyAndVisible];
        if(animated){
            self.myViewCtl.shadeView.alpha = 0;
            [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
                self.myViewCtl.shadeView.alpha = 1;
            }];
            self.showView.alpha = 0;
            self.showView.layer.shouldRasterize = YES;
            self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
            [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
                self.showView.alpha = 1;
                self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.2 animations:^{
                    self.showView.alpha = 1;
                    self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        self.showView.alpha = 1;
                        self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                    } completion:^(BOOL finished2) {
                        self.showView.layer.shouldRasterize = NO;
                    }];
                    
                }];
            }];
        }
    });
}

#pragma mark ---> 关闭按钮的点击事件
- (void)close
{
    [self hideAnimated:YES withCompletionBlock:nil];
}

- (void)closeWithBlcok:(void(^)())complete
{
    [self hideAnimated:YES withCompletionBlock:complete];
}

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion
{
    if (!animated) {
        [self cleanup];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
            self.myViewCtl.shadeView.alpha = 0;
        }];
        
        self.showView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
            self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.showView.alpha = 0;
                self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
            } completion:^(BOOL finished2){
                [self cleanup];
                if(completion){
                    completion();
                }
            }];
        }];
    });
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        _window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _window.opaque = NO;
        
        JYViewController *myViewCtl = [[JYViewController alloc] init];
        
        _window.rootViewController = myViewCtl;
        self.myViewCtl = myViewCtl;
    }
    return _window;
}

#pragma mark ---> 清空内容
- (void)cleanup
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.showView removeFromSuperview];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    [self.window removeFromSuperview];
    self.contentViewController = nil;
    self.window = nil;
}

- (void)dealloc
{
    [self cleanup];
}

@end

#pragma mark ==== JYShowView
@implementation JYShowView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self) {
        CALayer *styleLayer = [[CALayer alloc] init];
        styleLayer.cornerRadius = 4;
        styleLayer.shadowColor= [[UIColor whiteColor] CGColor];
        styleLayer.shadowOffset = CGSizeMake(0, 0);
        styleLayer.shadowOpacity = 0.5;
        styleLayer.borderWidth = 1;
        styleLayer.borderColor = [[UIColor whiteColor] CGColor];
        styleLayer.frame = CGRectInset(self.bounds, 12, 12);
        [self.layer addSublayer:styleLayer];
        self.styleLayer = styleLayer;
        
    }
    return self;
}

- (void)setPopBackgroundColor:(UIColor *)popBackgroundColor {
    if(_popBackgroundColor != popBackgroundColor){
        _popBackgroundColor = popBackgroundColor;
        self.styleLayer.backgroundColor = [popBackgroundColor CGColor];
    }
}

@end
