//
//  JYStudyController.m
//  WalkedTheLoad
//
//  Created by admin on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYStudyController.h"
#import "JYTitleScroller.h"

@interface JYStudyController ()

@end

@implementation JYStudyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTitleScrollView];
}

- (void)setupTitleScrollView
{
    __weak JYStudyController *weakSelf = self;
    
    JYTitleScroller *titleScrollView = [JYTitleScroller titleScrollerWithArray:@[@"最新", @"前端", @"移动开发", @"语言", @"游戏&图像", @"loT", @"数据库", @"业界", @"云计算", @"大数据", @"研发工具", @"软件工程", @"程序人生"]];
    titleScrollView.backgroundColor = setColor(214, 214, 214);
    titleScrollView.frame = CGRectMake(0, 80, screenW, 45);
    
    [self.view addSubview:titleScrollView];
    NSLog(@"%@", NSStringFromCGRect(titleScrollView.frame));
//    [titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(80);
//        make.leading.trailing.equalTo(weakSelf.view);
//        make.height.mas_equalTo(100);
//    }];
}

@end
