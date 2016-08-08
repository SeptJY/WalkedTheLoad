//
//  JYSignUpController.m
//  SeptWeiWei
//
//  Created by admin on 16/4/20.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYSignUpController.h"
#import "JYContentView.h"

@interface JYSignUpController ()

@property (strong, nonatomic) JYContentView *mContentView;

@property (strong, nonatomic) UIButton *signUpBtn;

@end

@implementation JYSignUpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubView];
    
    [self childSetupConstraints];
}

/** 添加子控件 */
- (void)addSubView
{
    [self.backgroundView addSubview:self.mContentView];
    [self.view addSubview:self.signUpBtn];
}

/** 重新父类的方法，解决pop过后导航栏不能掩藏的问题 */
- (void)backBtnOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---> 懒加载
- (JYContentView *)mContentView
{
    if (!_mContentView) {
        
        _mContentView = [JYContentView contenetView];
        
        _mContentView.backgroundColor = [UIColor clearColor];
    }
    return _mContentView;
}

- (UIButton *)signUpBtn
{
    if (!_signUpBtn) {
        
        _signUpBtn = [[UIButton alloc] init];
        
        _signUpBtn.backgroundColor = [UIColor clearColor];
        _signUpBtn.layer.borderWidth = 1;
        _signUpBtn.layer.borderColor = JYMainColor.CGColor;
        [_signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
        _signUpBtn.titleLabel.font = setBoldFont(15);
        [_signUpBtn setTitleColor:JYMainColor forState:UIControlStateNormal];
        _signUpBtn.layer.cornerRadius = 4;
        [_signUpBtn addTarget:self action:@selector(signUpBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpBtn;
}

#pragma mark ---> 注册按钮的点击事件
- (void)signUpBtnOnClick
{
    
}

#pragma mark ---> 设置控件的约束
- (void)childSetupConstraints
{
    __weak JYSignUpController *weakSelf = self;
    
    // 注册的内容视图
    [self.mContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.backgroundView).offset(10);
        make.trailing.equalTo(weakSelf.backgroundView).offset(-10);
        make.bottom.equalTo(weakSelf.backgroundView);
        make.top.equalTo(weakSelf.userImgBtn.mas_bottom).offset(8);
    }];
    
    // 注册按钮
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(weakSelf.backgroundView);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(25);
    }];
}

@end
