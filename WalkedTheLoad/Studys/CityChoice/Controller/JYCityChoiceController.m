//
//  JYCityChoiceController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityChoiceController.h"

@interface JYCityChoiceController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *searchBgView;

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *cityArray;

@end

@implementation JYCityChoiceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 自定义导航栏
    [self customNavigation];
    
    
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        
        _cityArray = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
        
        NSArray *mCityArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        
    }
    return _cityArray;
}

#pragma mark ---> 自定义导航栏
- (void)customNavigation
{
    // 设置状态栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 设置导航栏的背景色
    self.navigationController.navigationBar.barTintColor = JYMainColor;
    
    self.title = @"城市选择";
    
    UIButton *backBtn = [[UIButton alloc] init];
    
    [backBtn setImage:[UIImage imageNamed:@"city_choose_back_icon"] forState:UIControlStateNormal];
    backBtn.size = CGSizeMake(20, 20);
    [backBtn addTarget:self action:@selector(cityBackBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)cityBackBtnOnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/** 搜索框底部背景view */
- (UIView *)searchBgView
{
    if (!_searchBgView) {
        
        _searchBgView = [[UIView alloc] init];
        
        _searchBgView.backgroundColor = [UIColor cyanColor];
        
        [self.view addSubview:_searchBgView];
    }
    return _searchBgView;
}

/** 搜索框 */
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] init];
        
        _searchBar.backgroundColor = [UIColor yellowColor];
        
        [self.searchBgView addSubview:_searchBar];
    }
    return _searchBar;
}

#pragma mark ---> UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)viewDidLayoutSubviews
{
    self.searchBgView.frame = CGRectMake(0, 64, screenW, 44);
    
    self.searchBar.frame = CGRectMake(0, 0, screenW, 44);
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBgView.frame), screenW, screenH - CGRectGetMaxY(self.searchBgView.frame));
}

@end
