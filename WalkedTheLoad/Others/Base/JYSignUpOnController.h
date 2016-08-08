//
//  JYSignUpOnController.h
//  WalkedTheLoad
//
//  Created by Sept on 16/8/8.
//  Copyright © 2016年 丶九月. All rights reserved.
//

// 登录注册的基类

#import <UIKit/UIKit.h>
#import "JYBackgroundView.h"

#define rotationViewWidth (screenW - 40)
#define kRotationDuration 4.0
#define kRotationW (rotationViewWidth * 5 / 14 - 10)

@interface JYSignUpOnController : UIViewController

/** 设置背景view的size */
@property (assign, nonatomic) CGSize bgSize;

@property (strong, nonatomic) JYBackgroundView *backgroundView;

/** 用户头像 */
@property (strong, nonatomic) UIButton *userImgBtn;

/** 返回按钮的点击事件 */
- (void)backBtnOnClick;

@end
