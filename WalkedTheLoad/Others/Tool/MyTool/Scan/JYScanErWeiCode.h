//
//  JYScanErWeiCode.h
//  JYTest
//
//  Created by Sept on 16/7/26.
//  Copyright © 2016年 九月. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JYPreviewView.h"

@protocol JYScanErWeiCodeDelegate <NSObject>

@optional
- (void)erWeiCodeScanStringValue:(NSString *)str;

@end

@interface JYScanErWeiCode : NSObject

- (instancetype)initWithPreviewView:(JYPreviewView *)previewView;

@property (weak, nonatomic) id<JYScanErWeiCodeDelegate> delegate;

- (void)startSession;

- (void)stopSession;

@end
