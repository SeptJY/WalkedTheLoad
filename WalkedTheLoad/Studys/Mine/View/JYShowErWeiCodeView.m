//
//  JYShowErWeiCodeView.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/22.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYShowErWeiCodeView.h"

static NSTimeInterval const kTransformPart1AnimationDuration = 0.3;
static NSTimeInterval const kTransformPart2AnimationDuration = 0.4;

@interface JYShowErWeiCodeView ()

@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIView *lineView;  // 分割线

@property (strong, nonatomic) UIImageView *imgView;   // 头像
@property (strong, nonatomic) UIImageView *sexImgView;   // 显示性别的图片
@property (strong, nonatomic) UIImageView *codeImgView;  // 二维码

@property (strong, nonatomic) UILabel *titleLabel;  // 昵称
@property (strong, nonatomic) UILabel *bottomLabel;  // 底部的说明

@property (strong, nonatomic) UIButton *closeBtn;  // 关闭按钮

@end

@implementation JYShowErWeiCodeView

+ (instancetype)showErWeiCodeView
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureOnClick:)];
        
        [self addGestureRecognizer:tapGesture];
        
        [self makeConstraints];
    }
    return self;
}

- (void)startAnimation
{
    self.hidden = NO;
    [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
        self.centerView.alpha = 1;
        self.centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            self.centerView.alpha = 1;
            self.centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.centerView.alpha = 1;
                self.centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished2) {
                self.centerView.layer.shouldRasterize = NO;
            }];
            
        }];
    }];
}

- (void)stopAnimation
{
    [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
        self.centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.centerView.alpha = 0;
            self.centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
        } completion:^(BOOL finished2){
//            [self cleanup];
//            if(completion){
//                completion();
//            }
            self.hidden = YES;
        }];
    }];
}

#pragma mark ---> 关闭按钮的点击事件
- (void)closeBtnOnClick
{
    [self stopAnimation];
}

- (void)tapGestureOnClick:(UITapGestureRecognizer *)tapGesture
{
//    self.hidden = YES;
    [self stopAnimation];
}

#pragma mark ---> 懒加载控件
- (UIView *)centerView
{
    if (!_centerView) {
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _centerView;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"logo_icon"];
        
        
    }
    return _imgView;
}

- (UIImageView *)sexImgView
{
    if (!_sexImgView) {
        
        _sexImgView = [[UIImageView alloc] init];
        _sexImgView.backgroundColor = [UIColor redColor];
        
        
    }
    return _sexImgView;
}

- (UIImageView *)codeImgView
{
    if (!_codeImgView) {
        
        _codeImgView = [[UIImageView alloc] init];
        _codeImgView.backgroundColor = [UIColor cyanColor];
        
    
    }
    return _codeImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"iOS丶九月";
        
        
    }
    return _titleLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"扫一扫就能找到我";
        _bottomLabel.textColor = [UIColor grayColor];
        _bottomLabel.font = setFont(15);
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _bottomLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = setColor(214, 214, 214);
    }
    return _lineView;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"red_packge_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark ---> 设置控件约束
- (void)makeConstraints
{
    [self addSubview:self.centerView];
    [self.centerView addSubview:self.closeBtn];
    [self.centerView addSubview:self.imgView];
    [self.centerView addSubview:self.sexImgView];
    [self.centerView addSubview:self.codeImgView];
    [self.centerView addSubview:self.titleLabel];
    [self.centerView addSubview:self.bottomLabel];
    [self.centerView addSubview:self.lineView];
    
    __weak JYShowErWeiCodeView *weakSelf = self;
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenW - 100);
        make.height.mas_equalTo((screenW - 100) * 4 / 3);
        make.centerX.centerY.equalTo(weakSelf);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.centerView.mas_right).offset(-16);
        make.bottom.mas_equalTo(weakSelf.centerView.mas_top).offset(16);
        make.height.width.mas_equalTo(32);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.centerView).offset(15);
        make.top.mas_equalTo(weakSelf.centerView).offset(10);
        make.height.width.mas_equalTo(60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imgView.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.imgView);
    }];
    
    [self.sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).offset(8);
        make.centerY.mas_equalTo(weakSelf.imgView);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(18);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(weakSelf.centerView);
        make.top.mas_equalTo(weakSelf.imgView.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.centerView).offset(25);
        make.trailing.mas_equalTo(weakSelf.centerView).offset(-25);
        make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(10);
        make.height.mas_equalTo(weakSelf.codeImgView.mas_width);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf).offset(10);
        make.trailing.equalTo(weakSelf).offset(-10);
        make.bottom.equalTo(weakSelf.centerView).offset(-10);
    }];
}

- (void)layoutSubviews
{
//    CGFloat centerX = 50;
//    CGFloat centerW = screenW - centerX * 2;
//    CGFloat centerH = centerW * 3 / 2;
//    CGFloat centerY = ((screenH - 44) - centerH) * 0.5;
//    
//    self.centerView.frame = CGRectMake(centerX, centerY, centerW, centerH);
    
//    self.imgView.frame = CGRectMake(0, 0, centerW, centerH);
}

@end
