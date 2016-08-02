//
//  JYCityChoicesController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/2.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityChoiceController.h"
#import "JYHotCityCell.h"
#import "JYSearchBarCell.h"

static NSString *hotCity = @"hotCity";
static NSString *mSearchBar = @"searchBar";

@interface JYCityChoiceController () <UISearchBarDelegate, JYHotCityCellDelegate, JYSearchBarCellDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIView *_bgView;
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSDictionary *cityDict;

/** tableView的头部标题 */
@property (strong, nonatomic) NSMutableArray *titlesArray;

/** tableView的右边索引 */
@property (strong, nonatomic) NSMutableArray *indexsArray;

@property (strong, nonatomic) NSArray *hotCityArray;

@end

@implementation JYCityChoiceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 自定义导航栏
    [self customNavigation];
    
    // 获取城市数剧
    [self getCitysData];
    
    self.hotCityArray = @[@"北京", @"上海", @"深圳", @"赣州", @"于都", @"广州", @"厦门", @"三亚"];
    
    // 设置tableView索引的颜色
    self.tableView.sectionIndexColor = JYMainColor;
    
    // 初始化黑色背景View
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, screenW, screenH - 108)];
    
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.0;
    _bgView.hidden = YES;
    
    [self.view addSubview:_bgView];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark ---> 获取城市数据
- (void)getCitysData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    
    self.cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // 把cityDict字典中的所有key值按字母顺序排列
    [self.titlesArray addObjectsFromArray:[[self.cityDict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    [self.indexsArray addObjectsFromArray:self.titlesArray];
    //    [self.titlesArray addObjectsFromArray:self.letterArray];
    
    // 添加‘热门城市’、‘定位城市’到letterArray数组中
    [self.titlesArray insertObject:@"热门城市" atIndex:0];
    [self.titlesArray insertObject:@"定位城市" atIndex:0];
    
    [self.indexsArray insertObject:@"#" atIndex:0];
    [self.indexsArray insertObject:@"!" atIndex:0];
    [self.indexsArray insertObject:UITableViewIndexSearch atIndex:0];
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

/** 返回上一页 */
- (void)cityBackBtnOnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titlesArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section >= 3) ? [self.cityDict[self.titlesArray[section - 1]] count] : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {      // 搜索城市
        JYSearchBarCell *cell = [JYSearchBarCell cellWithTableView:tableView identifier:mSearchBar];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {    // 定位城市
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.backgroundColor = setColor(244, 244, 244);
        cell.textLabel.text = @"SB";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 2) {   // 热门城市
        JYHotCityCell *cell = [JYHotCityCell cellWithTableView:tableView ddentifier:hotCity hotCity:self.hotCityArray];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = setColor(244, 244, 244);
        
        return cell;
    } else {
        NSArray *array = self.cityDict[self.titlesArray[indexPath.section - 1]];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = array[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", self.cityDict[self.indexsArray[indexPath.section]][indexPath.row]);
    [JYDataManager sharedManager].currentCity = self.cityDict[self.indexsArray[indexPath.section]][indexPath.row];
    
    [self dismissViewControllerAnimated:YES completion:nil]; 
}

/** 设置头部的标题 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? nil : self.titlesArray[section - 1];
}

/** 设置cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 2:
            return (self.hotCityArray.count / 3 == 0) ? (self.hotCityArray.count / 3 * 35 + 10 * (self.hotCityArray.count / 3 + 1)) : ((self.hotCityArray.count / 3 + 1) * 35 + 10 * (self.hotCityArray.count / 3 + 2));
            break;
            
        default:
            return 44;
            break;
    }
}

/** 设置右边索引 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexsArray;
}

/** 自定义头部视图 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
    
    bgView.backgroundColor = setColor(244, 244, 244);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, screenW, 30)];
    
    label.text = (section == 0) ? nil : self.titlesArray[section - 1];
    label.font = setBoldFont(14);
    label.textColor = setColor(156, 156, 156);
    
    [bgView addSubview:label];
    
    return bgView;
}

#pragma mark == JYHotCityCellDelegate
- (void)hotCityBtnTitle:(NSString *)cityName
{
    [JYDataManager sharedManager].currentCity = cityName;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark == JYSearchBarCellDelegate
/** 显示黑色背景View */
- (void)searchBarTextDidBeginEditing
{
    _bgView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.alpha = 0.6;
    }];
}

/** 隐藏黑色背景View */
- (void)searchBarCancelButtonClicked
{
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        _bgView.hidden = YES;
    }];
}

/** 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索 */
- (void)searchBarText:(NSString *)text textDidChange:(NSString *)searchText
{
    
}

#pragma mark ---> 数组懒加载
- (NSMutableArray *)titlesArray
{
    if (!_titlesArray) {
        
        _titlesArray = [NSMutableArray array];
    }
    return _titlesArray;
}

- (NSMutableArray *)indexsArray
{
    if (!_indexsArray) {
        
        _indexsArray = [NSMutableArray array];
    }
    return _indexsArray;
}

- (void)viewDidLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, screenW, screenH);
}

@end
