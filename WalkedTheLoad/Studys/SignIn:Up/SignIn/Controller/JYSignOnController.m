//
//  JYSignOnController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/8.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYSignOnController.h"
#import "JYSignUpController.h"

@interface JYSignOnController ()

@property (strong, nonatomic) UIButton *weixinBtn;
@property (strong, nonatomic) UIButton *qqBtn;
@property (strong, nonatomic) UIButton *sinaBtn;

@property (strong, nonatomic) UILabel *othersLabel;
@property (strong, nonatomic) UIView *leftLine;
@property (strong, nonatomic) UIView *rightLine;

@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *forgetPwdBtn;
@property (strong, nonatomic) UIButton *signUpBtn;

@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UIView *centerView;


@property (strong, nonatomic) UIImageView *userIconView;
@property (strong, nonatomic) UIImageView *pwdImgView;

@property (strong, nonatomic) UITextField *userText;
@property (strong, nonatomic) UITextField *pwdText;

@property (strong, nonatomic) UIButton *backBtn;

@end

@implementation JYSignOnController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubView];
    
    [self childSetupConstraints];
}

/** 添加子控件 */
- (void)addSubView
{
    [self.backgroundView addSubview:self.bgView];
    [self.view addSubview:self.weixinBtn];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.sinaBtn];
    [self.view addSubview:self.othersLabel];
    [self.view addSubview:self.leftLine];
    [self.view addSubview:self.rightLine];
    [self.view addSubview:self.forgetPwdBtn];
    [self.view addSubview:self.signUpBtn];
    [self.bgView addSubview:self.pwdText];
    [self.bgView addSubview:self.centerView];
    [self.bgView addSubview:self.userIconView];
    [self.bgView addSubview:self.pwdImgView];
    [self.bgView addSubview:self.userText];
    [self.view addSubview:self.backBtn];
}

- (UIButton *)weixinBtn
{
    if (!_weixinBtn) {
        
        _weixinBtn = [[UIButton alloc] init];
        
        [_weixinBtn setImage:[UIImage imageNamed:@"ic_landing_wechat"] forState:UIControlStateNormal];
        [_weixinBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _weixinBtn.tag = 10;
    }
    return _weixinBtn;
}

- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        
        _qqBtn = [[UIButton alloc] init];
        
        [_qqBtn setImage:[UIImage imageNamed:@"ic_landing_qq"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _qqBtn.tag = 11;
    }
    return _qqBtn;
}

- (UIButton *)sinaBtn
{
    if (!_sinaBtn) {
        
        _sinaBtn = [[UIButton alloc] init];
        
        [_sinaBtn setImage:[UIImage imageNamed:@"ic_landing_microblog"] forState:UIControlStateNormal];
        [_sinaBtn addTarget:self action:@selector(otherLoginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sinaBtn.tag = 12;
    }
    return _sinaBtn;
}

- (UILabel *)othersLabel
{
    if (!_othersLabel) {
        
        _othersLabel = [[UILabel alloc] init];
        
        _othersLabel.text = @"第三方登录";
        _othersLabel.textColor = [UIColor grayColor];
        _othersLabel.font = setFont(12);
    }
    return _othersLabel;
}

- (UIView *)leftLine
{
    if (!_leftLine) {
        
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = JYMainColor;
    }
    return _leftLine;
}

- (UIView *)rightLine
{
    if (!_rightLine) {
        
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = JYMainColor;
        
        [self.view addSubview:_rightLine];
    }
    return _rightLine;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_nolmal_icon"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_seletect_icon"] forState:UIControlStateHighlighted];
        [_loginBtn setTitleColor:JYMainColor forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_loginBtn addTarget:self action:@selector(loginBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIButton *)forgetPwdBtn
{
    if (!_forgetPwdBtn) {
        
        _forgetPwdBtn = [self createBtnWithTitle:@"忘记密码?"];
        _forgetPwdBtn.tag = 13;
    }
    return _forgetPwdBtn;
}

- (UIButton *)signUpBtn
{
    if (!_signUpBtn) {
        
        _signUpBtn = [self createBtnWithTitle:@"快速注册"];
        _signUpBtn.tag = 14;
    }
    return _signUpBtn;
}

- (UIImageView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIImageView alloc] init];
        
        _bgView.image = [UIImage imageNamed:@"login_small_bg_view"];
    }
    return _bgView;
}

- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor grayColor];
    }
    return _centerView;
}

- (UIImageView *)userIconView
{
    if (!_userIconView) {
        _userIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_head_icon"]];
    }
    return _userIconView;
}

- (UIImageView *)pwdImgView
{
    if (!_pwdImgView) {
        _pwdImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password_icon"]];
    }
    return _pwdImgView;
}

- (UITextField *)userText
{
    if (!_userText) {
        _userText = [[UITextField alloc] init];
        
        _userText.placeholder = @"UserName";
        _userText.textColor = [UIColor blackColor];
    }
    return _userText;
}

- (UITextField *)pwdText
{
    if (!_pwdText) {
        _pwdText = [[UITextField alloc] init];
        
        _pwdText.placeholder = @"PassWord";
        _pwdText.textColor = [UIColor blackColor];
    }
    return _pwdText;
}

#pragma mark ---> 忘记密码和注册按钮的点击事件
- (void)forgetPwdBtnAndSignUpBtnOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 13:
            NSLog(@"%@", btn.currentTitle);
            break;
        case 14:
        {
            JYSignUpController *signUpCtl = [[JYSignUpController alloc] init];
            signUpCtl.bgSize = CGSizeMake(rotationViewWidth, 225 + 8 + kRotationW * 0.5);
            [self.navigationController pushViewController:signUpCtl animated:YES];
        }
            break;
    }
}

#pragma mark ---> 登录按钮的点击事件
- (void)loginBtnOnClick
{
    //    JYLog(@"登录");
}

#pragma mark ---> 其他登录方式按钮
- (void)otherLoginBtnOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 10:
            JYLog(@"微信登录");
            break;
        case 11:
        {
            
        }
            break;
        case 12:
            JYLog(@"新浪登录");
            break;
    }
}

/** 通过一个字符串返回一个按钮 */
- (UIButton *)createBtnWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitleColor:setColor(176, 187, 220) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = setFont(14);
    
    [btn addTarget:self action:@selector(forgetPwdBtnAndSignUpBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)childSetupConstraints
{
    __weak JYSignOnController *weakSelf = self;
    
    // 输入框的背景view
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backgroundView).offset(-20);
        make.leading.equalTo(weakSelf.backgroundView).offset(20);
        make.trailing.equalTo(weakSelf.backgroundView).offset(-20);
        make.top.mas_equalTo(weakSelf.userImgBtn.mas_bottom).offset(30);
    }];
    
    // 背景view的中心线
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.bgView);
    }];
    
    // 用户名的图标
    [self.userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.centerY.mas_equalTo(weakSelf.userText).offset(-5);
        make.size.mas_equalTo(CGSizeMake(22.0, 22.0));
    }];
    
    // 用户名的输入框
    [self.userText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.centerView.mas_top).offset(5);
        make.top.equalTo(weakSelf.bgView).offset(5);
        make.trailing.equalTo(weakSelf.bgView).offset(-5);
        make.left.mas_equalTo(weakSelf.userIconView.mas_right).offset(5);
    }];
    
    // 密码的图标
    [self.pwdImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(7);
        make.centerY.mas_equalTo(weakSelf.pwdText);
        make.size.mas_equalTo(CGSizeMake(28.0, 28.0));
    }];
    
    // 密码的输入框
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bgView).offset(-5);
        make.top.equalTo(weakSelf.centerView.mas_bottom).offset(5);
        make.trailing.equalTo(weakSelf.userText);
        make.left.mas_equalTo(weakSelf.pwdImgView.mas_right).offset(5);
    }];
    
    // 登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(25);
        make.height.mas_equalTo(40);
        make.leading.equalTo(weakSelf.view).offset(20);
        make.trailing.equalTo(weakSelf.view).offset(-20);
    }];
    
    // 忘记密码
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.loginBtn);
        make.top.mas_equalTo(weakSelf.loginBtn.mas_bottom).offset(8);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    // 注册按钮
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(weakSelf.loginBtn);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.mas_equalTo(weakSelf.forgetPwdBtn);
    }];
    
    // qq登录
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(50);
        make.bottom.equalTo(weakSelf.view).offset(-20);
        make.width.mas_equalTo(weakSelf.qqBtn.mas_height);
    }];
    
    // 微信登录
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.qqBtn.mas_right).offset(60);
        make.right.mas_equalTo(weakSelf.sinaBtn.mas_left).offset(-60);
        make.height.bottom.width.mas_equalTo(weakSelf.qqBtn);
    }];
    
    // 新浪登录
    [self.sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.view).offset(-50);
        make.width.height.bottom.mas_equalTo(weakSelf.qqBtn);
    }];
    
    // 第三方label
    [self.othersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.weixinBtn.mas_top).offset(-10);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    // lable 左边的线
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view).offset(20);
        make.right.mas_equalTo(weakSelf.othersLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(weakSelf.othersLabel);
    }];
    
    // lable 左边的线
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.view).offset(20);
        make.left.mas_equalTo(weakSelf.othersLabel.mas_right).offset(20);
        make.height.centerY.mas_equalTo(weakSelf.leftLine);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
