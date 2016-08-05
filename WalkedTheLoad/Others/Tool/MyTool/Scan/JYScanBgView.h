//
//  JYScanBgView.h
//  JYTest
//
//  Created by Sept on 16/7/26.
//  Copyright © 2016年 九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYScanBgView : UIView

/** 四个角的颜色 */
@property (strong, nonatomic) UIColor *cornerColor;

/** 滑动图片 */
@property (copy, nonatomic) NSString *scrollIcon;

@end
