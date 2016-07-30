//
//  JYHomeController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYHomeController.h"
#import "JYCityChoiceController.h"

@interface JYHomeController ()

@end

@implementation JYHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNavigation];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark ---> 初始化导航栏
- (void)setupNavigation
{
    // 设置状态栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 设置导航栏的背景色
    self.navigationController.navigationBar.barTintColor = JYMainColor;
    
    // 自定义导航栏的左边按钮
    UIButton *leftCityBtn = [[UIButton alloc] init];
    
    UIImage *image = [UIImage imageNamed:@"city_choose_icon"];
    
    [leftCityBtn setImage:image forState:UIControlStateNormal];
    [leftCityBtn setTitle:@"城市" forState:UIControlStateNormal];
    [leftCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftCityBtn.titleLabel.font = setFont(15);
    
    CGSize size = [NSString sizeWithText:leftCityBtn.currentTitle font:setFont(15) maxSize:CGSizeMake(70, 50)];
    //    NSLog(@"%@, %@", NSStringFromCGSize(size), NSStringFromCGSize(image.size));
    leftCityBtn.size = CGSizeMake(70, 30);
    // 设置按钮内容左对齐
    leftCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置按钮的文字在图片的右边
    leftCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, 0);
    leftCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, size.width, 0, 0);
    
    [leftCityBtn addTarget:self action:@selector(leftCityBtnOnColcik) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftCityBtn];
}

- (void)leftCityBtnOnColcik
{
//    JYCityChoiceController *city = [[JYCityChoiceController alloc] init];
    
    UINavigationController *navCrl = [[UINavigationController alloc] initWithRootViewController:[[JYCityChoiceController alloc] init]];
    
    [self presentViewController:navCrl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
