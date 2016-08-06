//
//  JYSignUpController.m
//  SeptWeiWei
//
//  Created by admin on 16/4/20.
//  Copyright © 2016年 九月. All rights reserved.
//

#import "JYSignUpController.h"
#import "JYBackgroundView.h"

#define rotationViewWidth (screenW - 40)
#define kRotationDuration 4.0

@interface JYSignUpController ()

@property (strong, nonatomic) JYBackgroundView *backgroundView;

/** 用户头像 */
@property (strong, nonatomic) UIImageView *userImgView;

//转圈速度
@property (assign, nonatomic) float rotationDuration;

@end

@implementation JYSignUpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置背景图片
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    imgView.image = [UIImage imageNamed:@"login_bg_icon"];
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
    
    [self initRound];
    [self startRotation];
    
    [self addSubView];
    
    [self setupConstraints];
}

- (void)initRound
{
    //Rotation
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    //default RotationDuration value
    if (self.rotationDuration == 0) {
        self.rotationDuration = kRotationDuration;
    }
    
    rotationAnimation.duration = self.rotationDuration;
    rotationAnimation.repeatCount = FLT_MAX;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO; //No Remove
    [self.userImgView.layer addAnimation:rotationAnimation forKey:@"rotation"];
}

- (void)startRotation
{
    self.view.layer.speed = 1.0;
    self.view.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [self.view.layer timeOffset];
    CFTimeInterval timeSincePause = [self.view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.view.layer.beginTime = timeSincePause;
}


- (void)addSubView
{
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.userImgView];
}

- (JYBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        
        _backgroundView = [[JYBackgroundView alloc] init];
    }
    return _backgroundView;
}

- (UIImageView *)userImgView
{
    if (!_userImgView) {
        
        _userImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_rotation_icon"]];
        
        _userImgView.userInteractionEnabled = YES;
    }
    return _userImgView;
}

- (void)setupConstraints
{
    __weak JYSignUpController *weakSelf = self;
    
    // 自定义画图的背景view
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100);
        make.bottom.equalTo(weakSelf.view).offset(-150);
        make.width.mas_equalTo(rotationViewWidth);
    }];
    
    // 旋转的图片
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(rotationViewWidth * 5 / 14 - 10, rotationViewWidth * 5 / 14 - 10));
        make.top.equalTo(weakSelf.view).offset(100 - (rotationViewWidth * 5 / 14 - 10) * 0.5);
    }];
}

@end
