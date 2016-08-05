//
//  JYEjectMenu.h
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYEjectMenuDelegate <NSObject>

@optional
- (void)ejectMenuBtnOnClick:(NSInteger)index;

@end

@interface JYEjectMenu : UIView

+ (instancetype)ejectMenuWithArray:(NSArray *)array;

@property (weak, nonatomic) id <JYEjectMenuDelegate>delegate;

@end
