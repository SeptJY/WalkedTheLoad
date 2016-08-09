//
//  JYRollingView.h
//  SeptRollingImages
//
//  Created by Sept on 16/4/18.
//  Copyright © 2016年 九月. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JYPageControlPositionNone,           //默认值 == PositionBottomCenter
    JYPageControlPositionHide,           //隐藏
    JYPageControlPositionTopCenter,      //中上
    JYPageControlPositionBottomLeft,     //左下
    JYPageControlPositionBottomCenter,   //中下
    JYPageControlPositionBottomRight     //右下
} JYPageControlPosition;

@protocol JYRollingViewDelegate <NSObject>

@optional
- (void)rollingViewImagesOnClick;

@end

@interface JYRollingView : UIView

@property (weak, nonatomic) id<JYRollingViewDelegate> delegate;

@property (nonatomic, assign) JYPageControlPosition pagePosition;

/**
 *  轮播的图片数组，可以是图片，也可以是网络路径
 */
@property (nonatomic, strong) NSArray *imageArray;

/**
 *  每一页停留时间，默认为5s，最少1s
 *  当设置的值小于1s时，则为默认值
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 *  图片描述的字符串数组，应与图片顺序对应
 *
 *  图片描述控件默认是隐藏的
 *  设置该属性后，会取消隐藏，显示在图片底部
 */
@property (nonatomic, strong) NSArray *describeArray;

@property (strong, nonatomic) UIColor *describeBgColor;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
+ (instancetype)rollingViewWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

- (instancetype)initWithimageArray:(NSArray *)imageArray;
+ (instancetype)rollingViewWithimageArray:(NSArray *)imageArray;

@end
