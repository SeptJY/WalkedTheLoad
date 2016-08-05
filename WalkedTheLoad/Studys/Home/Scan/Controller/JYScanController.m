//
//  JYScanController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/4.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYScanController.h"
#import "JYScanErWeiCode.h"

@interface JYScanController () <JYScanErWeiCodeDelegate>

@property (strong, nonatomic) JYScanErWeiCode *scanErWeiCode;

@property (strong, nonatomic) JYPreviewView *previewView;

@end

@implementation JYScanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码扫描";
}

#pragma mark -------------------------> 相机操作
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scanErWeiCode startSession];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.scanErWeiCode stopSession];
}

// 懒加载二维码扫描
- (JYScanErWeiCode *)scanErWeiCode
{
    if (!_scanErWeiCode) {
        
        _scanErWeiCode = [[JYScanErWeiCode alloc] initWithPreviewView:self.previewView];
        
        _scanErWeiCode.delegate = self;
    }
    return _scanErWeiCode;
}

- (void)erWeiCodeScanStringValue:(NSString *)str
{
    NSLog(@"%@", str);
//    JYWebController *webCtl = [[JYWebController alloc] init];
//    webCtl.urlStr = str;
//    
//    [self.navigationController pushViewController:webCtl animated:YES];
}

- (JYPreviewView *)previewView
{
    if (!_previewView) {
        
        _previewView = [[JYPreviewView alloc] init];
        _previewView.cornerColor = [UIColor cyanColor];
        
        [self.view addSubview:_previewView];
    }
    return _previewView;
}

- (void)viewWillLayoutSubviews
{
    self.previewView.frame = self.view.bounds;
}

@end
