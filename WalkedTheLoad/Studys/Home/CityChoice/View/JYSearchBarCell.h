//
//  JYSearchBarCell.h
//  WalkedTheLoad
//
//  Created by Sept on 16/8/2.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYSearchBarCellDelegate <NSObject>

@optional
/** UISearchBar取消按钮的点击事件 */
- (void)searchBarCancelButtonClicked;

/** UISearchBar开始编辑 */
- (void)searchBarTextDidBeginEditing;

/** 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索 */
- (void)searchBarText:(NSString *)text textDidChange:(NSString *)searchText;

@end

@interface JYSearchBarCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)ID;

@property (weak, nonatomic) id <JYSearchBarCellDelegate>delegate;

@end
