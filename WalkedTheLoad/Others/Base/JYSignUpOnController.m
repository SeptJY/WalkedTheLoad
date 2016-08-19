//
//  JYSignUpOnController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/8.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYSignUpOnController.h"

@interface JYSignUpOnController ()

@property (strong, nonatomic) UIButton *mBackBtn;

@end

@implementation JYSignUpOnController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置背景图片
    [self setupBackImageView];
    
    [self.view addSubview:self.userImgBtn];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.mBackBtn];
    
    // 设置动画
    [self initRound];
    [self startRotation];
    
    // 如果没有给bgView设置初始值
    if (self.bgSize.width == 0) {
        self.bgSize = CGSizeMake(rotationViewWidth, 200);
    }
    
    [self setupConstraints];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = YES;
//}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupBackImageView
{
    // 设置背景图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    imgView.image = [UIImage imageNamed:@"login_bg_icon"];
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
}

- (UIButton *)userImgBtn
{
    if (!_userImgBtn) {
        
        _userImgBtn = [[UIButton alloc] init];
        
        [_userImgBtn setBackgroundImage:[UIImage imageNamed:@"login_rotation_icon"] forState:UIControlStateNormal];
        [_userImgBtn addTarget:self action:@selector(userImgBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userImgBtn;
}

- (void)userImgBtnOnClick
{
    
}

- (JYBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        
        _backgroundView = [[JYBackgroundView alloc] init];
    }
    return _backgroundView;
}

/** 返回按钮 */
- (UIButton *)mBackBtn
{
    if (!_mBackBtn) {
        
        _mBackBtn = [[UIButton alloc] init];
        
        [_mBackBtn setImage:[UIImage imageNamed:@"login_back_icon"] forState:UIControlStateNormal];
        [_mBackBtn addTarget:self action:@selector(backBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mBackBtn;
}

/** 返回上一页 */
- (void)backBtnOnClick
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

/** 设置控件约束 */
- (void)setupConstraints
{
    __weak JYSignUpOnController *weakSelf = self;
    // 旋转的图片
    [self.userImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(kRotationW, kRotationW));
        make.top.equalTo(weakSelf.view).offset(100 - (rotationViewWidth * 5 / 14 - 10) * 0.5);
    }];
    
    // 自定义画图的背景view
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100);
        make.size.mas_equalTo(self.bgSize);
    }];
    
    // 返回按钮
    [self.mBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.top.equalTo(weakSelf.view).offset(20);
        make.leading.equalTo(weakSelf.view).offset(15);
    }];
}

- (void)initRound
{
    //Rotation
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    //  旋转速度
    rotationAnimation.duration = 4.0;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO; //No Remove
    [self.userImgBtn.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

- (void)startRotation
{
    self.view.layer.speed = 1.0;
    self.view.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [self.view.layer timeOffset];
    CFTimeInterval timeSincePause = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.view.layer.beginTime = timeSincePause;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
