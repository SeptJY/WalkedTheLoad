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
#import "JYLocationCell.h"
#import "JYCityShowCell.h"
#import "JYCityData.h"

static NSString *hotCity = @"hotCity";
static NSString *mSearchBar = @"searchBar";
static NSString *location = @"location";
static NSString *cityShow = @"cityShow";

@interface JYCityChoiceController () <UISearchBarDelegate, JYHotCityCellDelegate, JYSearchBarCellDelegate, UITableViewDataSource, UITableViewDelegate, JYLocationCellDelegate>
{
    UIView *_bgView;
}

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSDictionary *cityDict;

/** tableView的头部标题 */
@property (strong, nonatomic) NSMutableArray *titlesArray;

/** tableView的右边索引 */
@property (strong, nonatomic) NSMutableArray *indexsArray;

/** 字母数组 */
@property (strong, nonatomic) NSMutableArray *letterArray;

@property (strong, nonatomic) NSArray *hotCityArray;

@property (strong, nonatomic) UITableView *searchTableView;

/** 本地搜索匹配后的数据 */
@property (strong, nonatomic) NSMutableArray *searchArray;

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

/** 主要的tableView */
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/** 主要的tableView */
- (UITableView *)searchTableView
{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] init];
        
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.showsVerticalScrollIndicator = NO;
        _searchTableView.hidden = YES;
        
        [self.view addSubview:_searchTableView];
    }
    return _searchTableView;
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
    
    if (tableView == self.tableView) {
        return self.titlesArray.count + 1;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return (section >= 3) ? [self.cityDict[self.titlesArray[section - 1]] count] : 1;
    } else {
        return self.searchArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        switch (indexPath.section) {
            case 0:
            {
                JYSearchBarCell *cell = [JYSearchBarCell cellWithTableView:tableView identifier:mSearchBar];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                return cell;
            }
                break;
            case 1:
            {
                JYLocationCell *cell = [JYLocationCell cellWithTableView:tableView identifier:location];
                cell.backgroundColor = setColor(244, 244, 244);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                return cell;
            }
                break;
            case 2:
            {
                JYHotCityCell *cell = [JYHotCityCell cellWithTableView:tableView ddentifier:hotCity hotCity:self.hotCityArray];
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = setColor(244, 244, 244);
                
                return cell;
            }
                break;
                
            default:
            {
                NSArray *array = self.cityDict[self.titlesArray[indexPath.section - 1]];
                JYCityShowCell *cell = [JYCityShowCell cellWithTableView:tableView identifier:cityShow];
                
                cell.textLabel.text = array[indexPath.row];
                
                return cell;
            }
                break;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = self.searchArray[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (self.cityDict[self.indexsArray[indexPath.section]][indexPath.row]) {
            [JYDataManager sharedManager].currentCity = self.cityDict[self.indexsArray[indexPath.section]][indexPath.row];
        }
    } else {
        [JYDataManager sharedManager].currentCity = self.searchArray[indexPath.row];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 设置头部的标题 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return (section == 0) ? nil : self.titlesArray[section - 1];
    } else {
        return nil;
    }
}

/** 设置cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        switch (indexPath.section) {
            case 1:
                return 55;
                break;
            case 2:
                return (self.hotCityArray.count / 3 == 0) ? (self.hotCityArray.count / 3 * 35 + 10 * (self.hotCityArray.count / 3 + 1)) : ((self.hotCityArray.count / 3 + 1) * 35 + 10 * (self.hotCityArray.count / 3 + 2));
                break;
                
            default:
                return 44;
                break;
        }
    } else {
        return 44;
    }
}

/** 设置右边索引 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return self.indexsArray;
    } else {
        return nil;
    }
}

/** 自定义头部视图 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        // 1.自定义背景view
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
        
        bgView.backgroundColor = setColor(244, 244, 244);
        
        // 添加label显示文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, screenW, 30)];
        
        label.text = (section == 0) ? nil : self.titlesArray[section - 1];
        label.font = setBoldFont(14);
        label.textColor = setColor(156, 156, 156);
        
        [bgView addSubview:label];
        
        return bgView;
    } else {
        return nil;
    }
}

#pragma mark == JYHotCityCellDelegate
- (void)hotCityBtnTitle:(NSString *)cityName
{
    [JYDataManager sharedManager].currentCity = cityName;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---> JYLocationCellDelegate
- (void)locationCityBtnOnClick:(NSString *)city
{
    [JYDataManager sharedManager].currentCity = city;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark == JYSearchBarCellDelegate
/** 显示黑色背景View */
- (void)searchBarTextDidBeginEditing
{
    _bgView.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0.6;
    }];
}

/** 隐藏黑色背景View */
- (void)searchBarCancelButtonClicked
{
    // 当在显示搜索结果的时候点击取消的动画
    if (self.searchTableView.hidden == NO) {
        self.tableView.alpha = 0.7;
        self.tableView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.searchTableView.alpha = 0.0;
            self.tableView.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.searchTableView.hidden = YES;
            self.searchTableView.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.alpha = 0.0;
        } completion:^(BOOL finished) {
            _bgView.hidden = YES;
        }];
    }
}

/** 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索 */
- (void)searchBarText:(NSString *)text textDidChange:(NSString *)searchText
{
    if (text.length) {   // 当搜索框搜索内容不为空的时候
        [self.searchArray removeAllObjects];
        if ([NSString isLetterWithstring:text]) {   // 输入的是字母
            
            // 小写转成大写
            NSString *upperCaseString2 = text.uppercaseString;
            
            // 获取字符串中的第一个字母
            NSString *firstString = [upperCaseString2 substringToIndex:1];
            
            // 取出出入字符串中第一个字母key所存储的数据
            NSArray *array = [self.cityDict objectForKey:firstString];
            
            // 遍历第一个字母key获取的数组
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JYCityData *cityData = [[JYCityData alloc] init];
                
                cityData.name = obj;
                cityData.pinYin = [NSString charactor:obj getFirstCharactor:NO];
                [self.letterArray addObject:cityData];
            }];
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"pinYin BEGINSWITH[c] %@", text];
            
            NSArray *smallArray = [self.letterArray filteredArrayUsingPredicate:pred];
            
            [smallArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                JYCityData *model = obj;
                [self.searchArray addObject:model.name];
            }];
        }
        else {  // 输入文字的时候
            NSArray *allKeys = [[self.cityDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
            
            for (NSString *key in allKeys) {
                NSArray *keyArray = self.cityDict[key];
                
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",text];
                NSArray *array = [keyArray filteredArrayUsingPredicate:pred];
                
                [self.searchArray addObjectsFromArray:array];
            }
        }
        
        
        [self.searchTableView reloadData];
        _bgView.hidden = YES;
        self.searchTableView.hidden = NO;
    }
    else     // 搜索框内容为空的时候，掩藏searchTableView，显示bgView
    {
        self.searchTableView.hidden = YES;
        _bgView.hidden = NO;
    }
}

#pragma mark ---> UIScrollViewDelegate
/** 当第一次滑动的时候调用 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 发送通知，当滑动tableView的时候掩藏键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenKeybord" object:nil];
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

- (NSMutableArray *)letterArray
{
    if (!_letterArray) {
        
        _letterArray = [NSMutableArray array];
    }
    return _letterArray;
}

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (void)viewDidLayoutSubviews
{
    self.tableView.frame = CGRectMake(0, 0, screenW, screenH);
    self.searchTableView.frame = _bgView.frame;
}

@end
