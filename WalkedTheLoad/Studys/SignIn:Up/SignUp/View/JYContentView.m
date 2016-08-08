//
//  JYContentView.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/8.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYContentView.h"

@interface JYContentView ()
{
    NSTimer *_timer;
    NSInteger _second;
}

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *resetPsd;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JYContentView

+ (instancetype)contenetView
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"JYContentView" owner:nil options:nil] lastObject];
        
        // 创建一个定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerReSendCode) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return self;
}


/** 60秒后可点击重复发送验证码 */
- (void)timerReSendCode
{
    _second--;
    
//    NSString *mStr = [NSString stringWithFormat:@"(%lds)", (long)_second];
    
    self.timeLabel.text = [NSString stringWithFormat:@"(%02lds)", (long)_second];
    if (_second == 0) {    // 当等于0时，停止定时器
        
        [_timer setFireDate:[NSDate distantFuture]];
        
        self.sendCodeBtn.enabled = YES;
        self.timeLabel.hidden = YES;
        self.sendCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

/** 发送验证码 */
- (IBAction)contentViewSendCodeOnClick:(UIButton *)sender
{
    // 开始定时器
    _second = 60;
    self.timeLabel.hidden = NO;
    self.sendCodeBtn.enabled = NO;
    self.sendCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 31, 0, 0);
    [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [_timer setFireDate:[NSDate date]];
}
@end
