//
//  JYCityChoicesController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/2.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityChoicesController.h"
#import "JYHotCityCell.h"
#import "JYSearchBarCell.h"

static NSString *hotCity = @"hotCity";
static NSString *mSearchBar = @"searchBar";

@interface JYCityChoicesController () <UISearchBarDelegate>

@property (strong, nonatomic) NSDictionary *cityDict;

/** tableView的头部标题 */
@property (strong, nonatomic) NSMutableArray *titlesArray;

/** tableView的右边索引 */
@property (strong, nonatomic) NSMutableArray *indexsArray;

/** 字母 */
//@property (strong, nonatomic) NSMutableArray *letterArray;


@property (strong, nonatomic) NSArray *hotCityArray;

@end

@implementation JYCityChoicesController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor redColor];
    
    // 自定义导航栏
    [self customNavigation];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 10);
    
    [self getCitysData];
    
    self.hotCityArray = @[@"北京", @"上海", @"深圳", @"赣州", @"于都", @"广州", @"厦门", @"三亚"];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 3:
            return [self.cityDict[self.titlesArray[section - 3]] count];
            break;
            
        default:
            return 1;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section = %ld", (long)indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            JYSearchBarCell *cell = [JYSearchBarCell cellWithTableView:tableView identifier:mSearchBar];
//            cell.sp
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.backgroundColor = setColor(244, 244, 244);
            cell.textLabel.text = @"SB";
            
            return cell;
        }
            break;
        case 2:
        {
            JYHotCityCell *cell = [JYHotCityCell cellWithTableView:tableView ddentifier:hotCity hotCity:self.hotCityArray];
            cell.backgroundColor = setColor(244, 244, 244);
            
            return cell;
        }
            break;
        default:
        {
            NSLog(@"%ld, %ld", (long)indexPath.section, (unsigned long)self.titlesArray.count);
            NSArray *array = self.cityDict[self.titlesArray[indexPath.section - 1]];
            NSLog(@"%@, %@", self.titlesArray[indexPath.section - 1], array);
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
    return (section == 0) ? nil : self.titlesArray[section - 1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 2:
            return (self.hotCityArray.count / 3 == 0) ? (self.hotCityArray.count / 3 * 40 + 10 * (self.hotCityArray.count / 3 + 1)) : ((self.hotCityArray.count / 3 + 1) * 40 + 10 * (self.hotCityArray.count / 3 + 2));
            break;
            
        default:
            return 44;
            break;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexsArray;
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

@end
