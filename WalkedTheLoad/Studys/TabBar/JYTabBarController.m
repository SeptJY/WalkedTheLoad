//
//  JYTabBarController.m
//  WalkedTheLoad
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYHomeController.h"
#import "JYNewsController.h"
#import "JYMineController.h"
#import "JYLifeController.h"
#import "JYStudyController.h"

#import "JYNavigationController.h"

@interface JYTabBarController ()

@end

@implementation JYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self setupChildViewControllers];
}


/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    JYHomeController *homeCtl = [[JYHomeController alloc] init];
    [self setupOneChildViewController:homeCtl title:@"九月" image:@"tabBar_home_icon" selectedImage:@"tabBar_home_icon_click"];
    
    JYStudyController *studyCtl = [[JYStudyController alloc] init];
    [self setupOneChildViewController:studyCtl title:@"学习" image:@"tabBar_home_icon" selectedImage:@"tabBar_home_icon_click"];
    
    JYNewsController *newsCtl = [[JYNewsController alloc] init];
    [self setupOneChildViewController:newsCtl title:@"新闻" image:@"tabBar_home_icon" selectedImage:@"tabBar_home_icon_click"];
    
    JYLifeController *lifeCtl = [[JYLifeController alloc] init];
    [self setupOneChildViewController:lifeCtl title:@"生活" image:@"tabBar_home_icon" selectedImage:@"tabBar_home_icon_click"];
    
    JYMineController *mineCtl = [[JYMineController alloc] init];
    [self setupOneChildViewController:mineCtl title:@"我的" image:@"tabBar_home_icon" selectedImage:@"tabBar_home_icon_click"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
//    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = JYMainColor;
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
//    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[JYNavigationController alloc] initWithRootViewController:vc]];
}

@end
