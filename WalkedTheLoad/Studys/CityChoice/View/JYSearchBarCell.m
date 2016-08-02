//
//  JYSearchBarCell.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/2.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYSearchBarCell.h"

@interface JYSearchBarCell () <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation JYSearchBarCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)ID
{
    JYSearchBarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JYSearchBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 修改UISearchBar 取消按钮的颜色和title
        [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
        [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:setColor(124, 124, 124)];
    }
    return self;
}

/** 搜索框 */
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"city_search_icon"] forState:UIControlStateNormal];
        _searchBar.placeholder = @"输入城市名或拼音查询";
        _searchBar.delegate = self;
        // 设置提示文字与搜索图标的间距
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(10, 0);
        
        [self.contentView addSubview:_searchBar];
    }
    return _searchBar;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = setColor(214, 214, 214);
        
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

#pragma mark - UISearchBar得到焦点并开始编辑时，执行该方法  UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 显示UISearchBar取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 设置取消按的属性
    for (UIView *view in [[searchBar.subviews firstObject] subviews]) {
        if ([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton *cancleBtn = (UIButton *)view;
            
            cancleBtn.titleLabel.font = setFont(14);
        }
    }
    
    if(searchBar.text.length==0||[searchBar.text isEqualToString:@""]||[searchBar.text isKindOfClass:[NSNull class]])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing)]) {
            [self.delegate searchBarTextDidBeginEditing];
        }
    }
}

// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked)]) {
        [self.delegate searchBarCancelButtonClicked];
    }
}

// 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarText:textDidChange:)]) {
        [self.delegate searchBarText:searchBar.text textDidChange:searchText];
    }
}

- (void)layoutSubviews
{
    self.searchBar.frame = CGRectMake(0, 0, self.width - 10, self.height);
    
    self.lineView.frame = CGRectMake(0, self.height - 0.5, screenW, 0.5);
}

@end
