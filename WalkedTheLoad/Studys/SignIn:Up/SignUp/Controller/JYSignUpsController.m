//
//  JYSignUpsController.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/6.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYSignUpsController.h"

#define rotationViewWidth (screenW - 40)
#define kRotationDuration 4.0

@interface JYSignUpsController ()

/** 用户头像 */
@property (strong, nonatomic) UIImageView *userImgView;

//转圈速度
@property (assign, nonatomic) float rotationDuration; 

@end

@implementation JYSignUpsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    [self.view addSubview:self.userImgView];
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
    __weak JYSignUpsController *weakSelf = self;
    
    // 旋转的图片
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(rotationViewWidth * 5 / 14 - 10, rotationViewWidth * 5 / 14 - 10));
        make.top.equalTo(weakSelf.view).offset(100 - (rotationViewWidth * 5 / 14 - 10) * 0.5);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
