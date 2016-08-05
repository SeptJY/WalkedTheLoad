//
//  JYPreviewView.h
//  SeptOfCamera
//
//  Created by Sept on 16/1/5.
//  Copyright © 2016年 九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface JYPreviewView : UIView

@property (nonatomic) AVCaptureSession *session;

/** 四个角的颜色 */
@property (strong, nonatomic) UIColor *cornerColor;

/** 滑动图片 */
@property (copy, nonatomic) NSString *scrollIcon;

@end
