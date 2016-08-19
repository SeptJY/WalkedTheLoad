//
//  JYShowErWeiCode.h
//  WalkedTheLoad
//
//  Created by Sept on 16/8/11.
//  Copyright © 2016年 丶九月. All rights reserved.
//

//  显示二维码的动画view

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  关闭按钮的位置
 */
typedef NS_ENUM(NSInteger, JYBtnPosition) {
    JYBtnPositionNone = 0,    // 无
    JYBtnPositionLeft = 1 << 0,      // 左上角
    JYBtnPositionRight = 2 << 0       // 右上角
};

/**
 *  蒙板的背景色
 */
typedef NS_ENUM(NSInteger, JYShadeBackgroundColor) {
    ShadeBackgroundGradient = 0,     // 渐变色
    ShadeBackgroundSolid = 1 << 0    // 固定色
};

typedef void(^completeBlock)(void);

@interface JYShowErWeiCode : NSObject

+ (JYShowErWeiCode *)sharedInstance;

@property (assign, nonatomic) JYShadeBackgroundColor shadeBgColor;

@property (assign, nonatomic) JYBtnPosition position;

@property (strong, nonatomic) UIColor *popBackgroudColor;//弹出视图的背景色

@property (assign, nonatomic) BOOL tapOutsideToDismiss;//点击蒙板是否弹出视图消失

/**
 *  弹出要展示的View
 *
 *  @param presentView show View
 *  @param animated    是否动画
 */
- (void)showWithPresentView:(UIView *)presentView animated:(BOOL)animated;

/**
 *  关闭弹出视图
 *
 *  @param complete complete block
 */
- (void)closeWithBlcok:(void(^)())complete;

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completionl;

@end
