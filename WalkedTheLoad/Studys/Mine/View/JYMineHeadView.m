//
//  JYMineHeadView.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/9.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYMineHeadView.h"
#import "LXRoundView.h"

@interface JYMineHeadView () <LXRoundViewDelegate>

@property (strong, nonatomic) UIImageView *bgImgView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIButton *centerBtn;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) UILabel *nickLabel;

@property (strong, nonatomic) UILabel *infoLabel;

@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) LXRoundView *roundView;

@end

@implementation JYMineHeadView

+ (instancetype)headView
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubviews];
        
        [self makeConstraints];
        
        self.roundView = [[LXRoundView alloc] initWithFrame:CGRectMake(0, 45, screenW, 50)];
        
        self.roundView.dataSource = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5",@"icon6",@"icon7",@"icon8",@"icon9"];
        self.roundView.delegate = self;
        
        [self addSubview:self.roundView];
    }
    return self;
}

- (void)addSubviews
{
    [self addSubview:self.bgImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.centerBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.nickLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.bottomView];
}

- (void)makeConstraints
{
    __weak JYMineHeadView *weakSelf = self;
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf);
        make.height.mas_equalTo(screenH * 0.3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(20);
        make.centerX.equalTo(weakSelf);
    }];
    
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenH * 0.15, screenH * 0.15));
        make.centerX.equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.bgImgView.mas_bottom).offset(screenH * 0.15 * 0.5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.centerBtn.mas_bottom).offset((screenH * 0.1) - (screenH * 0.15 * 0.5) * 0.5 - 8);
        make.height.mas_equalTo(1);
        make.leading.equalTo(weakSelf).offset(50);
        make.trailing.equalTo(weakSelf).offset(-50);
    }];
    
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.lineView.mas_top).offset(-5);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lineView).offset(10);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(weakSelf);
        make.height.mas_equalTo(5);
    }];
}

#pragma mark ---> 圆形头像按钮的点击事件
- (void)centerHeadImgBtnOnClick
{
    
}

#pragma mark ---> LXRoundViewDelegate
- (void)roundView:(LXRoundView *)roundView didShowItemAtIndex:(NSInteger)itemIndex{
    self.bgImgView.image = [UIImage imageNamed:roundView.dataSource[itemIndex]];
}

/** 中间圆形头像按钮 */
- (UIButton *)centerBtn
{
    if (!_centerBtn) {
        
        _centerBtn = [[UIButton alloc] init];
        
        UIImage *img = [UIImage imageNamed:@"logo_icon"];
        _centerBtn.layer.cornerRadius = screenH * 0.15 * 0.5;
        [_centerBtn setBackgroundImage:[UIImage clipYuanXingImg:img] forState:UIControlStateNormal];
        _centerBtn.layer.borderWidth = 5;
        _centerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_centerBtn addTarget:self action:@selector(centerHeadImgBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

/** 背景图片 */
- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] init];
        
        _bgImgView.image = [UIImage imageNamed:@"mine_define_icon"];
    }
    return _bgImgView;
}

/** 标题 */
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.text = @"我的主页";
        _titleLabel.font = setBoldFont(17);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

/** 昵称和个人信息中间的线 */
- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = JYMainColor;
    }
    return _lineView;
}

/** 显示昵称的label */
- (UILabel *)nickLabel
{
    if (!_nickLabel) {
        
        _nickLabel = [[UILabel alloc] init];
        
        _nickLabel.text = @"丶九月";
        _nickLabel.font = setFont(15);
        _nickLabel.textColor = JYMainColor;
    }
    return _nickLabel;
}

/** 信息显示的label */
- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        
        _infoLabel = [[UILabel alloc] init];
        
        _infoLabel.text = @"23岁、180cm、72.5kg";
        _infoLabel.font = setFont(15);
        _infoLabel.textColor = JYMainColor;
    }
    return _infoLabel;
}

/** 信息显示的label */
- (UIView *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[UILabel alloc] init];
        
        _bottomView.backgroundColor = setColor(224, 224, 224);
    }
    return _bottomView;
}

/** 信息显示的label */
- (LXRoundView *)roundView
{
    if (!_roundView) {
        
        
    }
    return _roundView;
}


- (void)layoutSubviews
{
//    self.roundView.frame = CGRectMake(0, 60, screenW, 50);
//    NSLog(@"%@", self.subviews);
}

@end
