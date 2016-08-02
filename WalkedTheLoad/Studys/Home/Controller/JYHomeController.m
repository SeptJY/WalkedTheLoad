//
//  JYHomeController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYHomeController.h"
#import "JYCityChoiceController.h"
#import "JYCityChoicesController.h"

@interface JYHomeController ()

@property (strong, nonatomic) UIButton *leftCityBtn;

@end

@implementation JYHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNavigation];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[JYDataManager sharedManager] addObserver:self forKeyPath:@"currentCity" options:NSKeyValueObservingOptionNew context:JYCureentCity];
    
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIButton *)leftCityBtn
{
    if (!_leftCityBtn) {
        // 自定义导航栏的左边按钮
        _leftCityBtn = [[UIButton alloc] init];
        
        UIImage *image = [UIImage imageNamed:@"city_choose_icon"];
        
        [_leftCityBtn setImage:image forState:UIControlStateNormal];
        [_leftCityBtn setTitle:@"城市" forState:UIControlStateNormal];
        [_leftCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftCityBtn.titleLabel.font = setFont(15);
        
        CGSize size = [NSString sizeWithText:_leftCityBtn.currentTitle font:setFont(15) maxSize:CGSizeMake(70, 50)];
        //    NSLog(@"%@, %@", NSStringFromCGSize(size), NSStringFromCGSize(image.size));
        _leftCityBtn.size = CGSizeMake(70, 30);
        // 设置按钮内容左对齐
        _leftCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 设置按钮的文字在图片的右边
        _leftCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, 0);
        _leftCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, size.width, 0, 0);
        
        [_leftCityBtn addTarget:self action:@selector(leftCityBtnOnColcik) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftCityBtn;
}

#pragma mark ---> 初始化导航栏
- (void)setupNavigation
{
    // 设置状态栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 设置导航栏的背景色
    self.navigationController.navigationBar.barTintColor = JYMainColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftCityBtn];
}

- (void)leftCityBtnOnColcik
{
//    JYCityChoiceController *city = [[JYCityChoiceController alloc] init];
    
    UINavigationController *navCrl = [[UINavigationController alloc] initWithRootViewController:[[JYCityChoicesController alloc] init]];
    
    [self presentViewController:navCrl animated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == JYCureentCity) {
        [self.leftCityBtn setTitle:[JYDataManager sharedManager].currentCity forState:UIControlStateNormal];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [[JYDataManager sharedManager] removeObserver:self forKeyPath:@"currenCity"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
