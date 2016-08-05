//
//  JYPreviewView.m
//  SeptOfCamera
//
//  Created by Sept on 16/1/5.
//  Copyright © 2016年 九月. All rights reserved.
//

@import AVFoundation;

#import "JYPreviewView.h"
#import "JYScanBgView.h"

@interface JYPreviewView ()

@property (strong, nonatomic) JYScanBgView *scanBgView;

@end

@implementation JYPreviewView

- (JYScanBgView *)scanBgView
{
    if (!_scanBgView) {
        
        _scanBgView = [[JYScanBgView alloc] init];
        _scanBgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_scanBgView];
    }
    return _scanBgView;
}

// 设置四个角的颜色
- (void)setCornerColor:(UIColor *)cornerColor
{
    _cornerColor = cornerColor;
    
    self.scanBgView.cornerColor = cornerColor;
}

/** 滑动图片 */
- (void)setScrollIcon:(NSString *)scrollIcon
{
    _scrollIcon = scrollIcon;
    
    self.scanBgView.scrollIcon = scrollIcon;
}

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    return previewLayer.session;
}

- (void)setSession:(AVCaptureSession *)session
{
    AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
    previewLayer.session = session;
}

- (void)layoutSubviews
{
    self.scanBgView.frame = self.bounds;
}

@end
