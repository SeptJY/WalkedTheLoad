//
//  JYMineController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/8.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYMineController.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "JYMineHeadView.h"
#import "JYMineCell.h"
#import "JYShowErWeiCodeView.h"
#import "JYEducationController.h"

@interface JYMineController ()
{
    JYMineHeadView *_mineHeadView;
    NSArray *_titleArray;
    NSArray *_imgArray;
}

@property (strong, nonatomic) UIView *cardView;

@property (strong, nonatomic) JYShowErWeiCodeView *showView;

@end

@implementation JYMineController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    // tableView上面多出来20个像素，是因为自动布局的缘故
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _mineHeadView = [JYMineHeadView headView];
    _mineHeadView.frame = CGRectMake(0, 0, screenW, screenH * 0.5);
    self.tableView.tableHeaderView = _mineHeadView;
    [self.tableView registerClass:[JYMineCell class] forCellReuseIdentifier:@"mine"];
    
    _titleArray = @[@"我的名片", @"联系方式", @"学习历程", @"工作经验", @"完善资料", @"设置"];
    
    _imgArray = @[@"mine_erWeiCode_icon", @"mine_lianXiFangShi_icon", @"mine_erWeiCode_icon", @"mine_lianXiFangShi_icon", @"mine_erWeiCode_icon", @"mine_lianXiFangShi_icon"];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"aaaaa");
//    NSLog(@"%@", NSStringFromCGRect(testBtn.frame));
}

- (UIView *)cardView
{
    if (!_cardView) {
        
        _cardView = [[UIView alloc] init];
        
        _cardView.backgroundColor = [UIColor cyanColor];
        
//        [self.view addSubview:_cardView];
        
//        __weak JYMineController *weakSelf = self;
//        [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(weakSelf.view).offset(50);
//            make.trailing.equalTo(weakSelf.view).offset(-50);
//            make.centerX.centerY.equalTo(weakSelf.view);
//            make.height.mas_equalTo((screenW - 100) * 16 / 9);
//        }];
    }
    return _cardView;
}

- (JYShowErWeiCodeView *)showView
{
    if (!_showView) {
        
        _showView = [[JYShowErWeiCodeView alloc] init];
        _showView.hidden = YES;
        
        [self.view addSubview:_showView];
    }
    return _showView;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JYMineCell *cell = [JYMineCell cellWithTableView:tableView];
    cell.imageView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
//            [JYShowErWeiCode sharedInstance].shadeBgColor = ShadeBackgroundSolid;
//            [JYShowErWeiCode sharedInstance].position = JYBtnPositionRight;
//            [[JYShowErWeiCode sharedInstance] showWithPresentView:self.cardView animated:YES];
//            self.showView.hidden = NO;
            [self.showView startAnimation];
        }
            break;
        case 2:
        {
            JYEducationController *education = [[JYEducationController alloc] init];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewWillLayoutSubviews
{
//    self.cardView.frame = CGRectMake(50, (screenH - ((screenW - 100) * 16 / 9)) * 0.5, screenW - 100, (screenW - 100) * 16 / 9);
    
    self.showView.frame = self.view.bounds;
}

@end
