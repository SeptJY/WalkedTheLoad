//
//  JYCityChoiceController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityChoiceController.h"
#import "JYProvinceList.h"
#import "JYAllCity.h"
#import "JYHotCityCell.h"

static NSString *hotCity = @"hotCity";

@interface JYCityChoiceController () <UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate>

@property (strong, nonatomic) UIView *searchBgView;

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSDictionary *cityDict;

@property (strong, nonatomic) NSMutableArray *letterArray;

@property (strong, nonatomic) NSArray *hotCityArray;

@end

@implementation JYCityChoiceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 自定义导航栏
    [self customNavigation];
    
    [self getCityArray];
    
    self.hotCityArray = @[@"北京", @"上海", @"深圳", @"赣州", @"于都", @"广州", @"厦门", @"三亚"];
    
    // 修改UISearchBar 取消按钮的颜色和title
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:setColor(124, 124, 124)];
}

- (NSMutableArray *)letterArray
{
    if (!_letterArray) {
        
        _letterArray = [NSMutableArray array];
    }
    return _letterArray;
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)getCityArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    
    self.cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // 把cityDict字典中的所有key值按字母顺序排列
    [self.letterArray addObjectsFromArray:[[self.cityDict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    // 添加‘热门城市’、‘定位城市’到letterArray数组中
    [self.letterArray insertObject:@"热门城市" atIndex:0];
    [self.letterArray insertObject:@"定位城市" atIndex:0];
//    [self.letterArray insertObject:UITableViewIndexSearch atIndex:0];
//    NSLog(@"%@, %lu", self.letterArray, (unsigned long)self.letterArray.count);
}

//获取某个字符串或者汉字的首字母.
- (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    
    return [pinYin substringToIndex:1];
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
        
//        [_tableView registerClass:[JYHotCityCell class] forCellReuseIdentifier:hotCity];
        
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
        _searchBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
//        _searchBar.scopeBarBackgroundImage = [UIImage imageWithColor:[UIColor redColor]];
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"city_search_icon"] forState:UIControlStateNormal];
        _searchBar.placeholder = @"输入城市名或拼音查询";
        _searchBar.delegate = self;
        
        
        [self.searchBgView addSubview:_searchBar];
    }
    return _searchBar;
}

#pragma mark - UISearchBar得到焦点并开始编辑时，执行该方法  UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    if(searchBar.text.length==0||[searchBar.text isEqualToString:@""]||[searchBar.text isKindOfClass:[NSNull class]])
    {
        
    }
    else
    {
//        NSLog(@"%@", searchBar.text);
    }
    
    // return YES;
}

// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

// 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchBar.text);
}

#pragma mark ---> UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.letterArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld", (long)section);
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;

        default:
        {
            NSArray *array = self.cityDict[self.letterArray[section]];
            return array.count;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"SB";
            
            return cell;
        }
            break;
        case 1:
        {
            JYHotCityCell *cell = [JYHotCityCell cellWithTableView:tableView ddentifier:hotCity hotCity:self.hotCityArray];
            cell.backgroundColor = setColor(244, 244, 244);
            
            return cell;
        }
            break;
            
        default:
        {
            NSArray *array = self.cityDict[self.letterArray[indexPath.section]];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = array[indexPath.row];
            
            return cell;
        }
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.letterArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
        case 1:
            return (self.hotCityArray.count / 3 == 0) ? (self.hotCityArray.count / 3 * 40 + 10 * (self.hotCityArray.count / 3 + 1)) : ((self.hotCityArray.count / 3 + 1) * 40 + 10 * (self.hotCityArray.count / 3 + 2));
            break;
            
        default:
            return 44;
            break;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.letterArray;
}

- (void)viewDidLayoutSubviews
{
    self.searchBgView.frame = CGRectMake(0, 64, screenW, 44);
    
    self.searchBar.frame = CGRectMake(0, 0, screenW, 44);
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBgView.frame), screenW, screenH - CGRectGetMaxY(self.searchBgView.frame));
}

@end
