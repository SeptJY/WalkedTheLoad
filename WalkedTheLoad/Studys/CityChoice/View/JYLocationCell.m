//
//  JYLocationCell.m
//  WalkedTheLoad
//
//  Created by Sept on 16/8/3.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYLocationCell.h"
#import <CoreLocation/CoreLocation.h>

const static NSInteger margin = 10;
const static NSInteger space = 15;

typedef NS_ENUM(NSUInteger, JYLocationState) {
    JYLocationStateSucces,
    JYLocationStateError,
    JYLocationStateNoNet,
};

@interface JYLocationCell () <CLLocationManagerDelegate>
{
    //定位
    CLLocation *_checkLocation;//用于保存位置信息
}

@property (strong, nonatomic) UIButton *cityBtn;

@property (strong, nonatomic) UILabel *label;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) CLLocationManager *locationManager;

/** 判断是否定位成功 */
@property (assign, nonatomic) JYLocationState state;

@end

@implementation JYLocationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)ID
{
    JYLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JYLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self findCurrentLocation];
    }
    return self;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        
    }
    return _locationManager;
}

- (UIActivityIndicatorView*)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activityIndicatorView.color = [UIColor grayColor];
        _activityIndicatorView.hidesWhenStopped = YES;
        
        [self.contentView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

- (UILabel*)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.text = @"定位中...";
        _label.font = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (UIButton *)cityBtn
{
    if (!_cityBtn) {
        
        _cityBtn = [[UIButton alloc] init];
        
        _cityBtn.hidden = YES;
        _cityBtn.titleLabel.font = setFont(15);
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cityBtn.backgroundColor = [UIColor whiteColor];
        _cityBtn.layer.cornerRadius = 4;
        _cityBtn.layer.borderWidth = 0.5;
        _cityBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor grayColor]);
        [_cityBtn addTarget:self action:@selector(locationCityBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_cityBtn];
    }
    return _cityBtn;
}

- (void)locationCityBtnOnClick
{
    switch (self.state) {
        case JYLocationStateSucces:
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationCityBtnOnClick:)]) {
                [self.delegate locationCityBtnOnClick:[JYLocationCell delectedSubStringOfStr:self.cityBtn.currentTitle]];
            }
            break;
        case JYLocationStateError:
            [self findCurrentLocation];
            self.cityBtn.hidden = YES;
            self.label.hidden = NO;
            break;
        default:
            break;
    }
}

- (UIView *)lineView
{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = setColor(214, 214, 214);
        
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (void)layoutSubviews
{
    CGFloat activityWH = 35;
    CGFloat activityY = 5;
    self.activityIndicatorView.frame = CGRectMake(15, activityY, activityWH, activityWH);
    
    self.label.frame = CGRectMake(CGRectGetMaxX(self.activityIndicatorView .frame), activityY, 200, activityWH);
    
    self.lineView.frame = CGRectMake(0, self.height - 0.5, screenW, 0.5);
    
    // 显示定位城市的按钮
    CGFloat btnW = (screenW - 3 * space - 2 * margin) / 3;
    CGFloat btnH = 35;
    CGFloat btnY = 5;
    
    self.cityBtn.frame = CGRectMake(15, btnY, btnW, btnH);
}

- (void)findCurrentLocation {
    
    // 让小菊花开始任务
    [self.activityIndicatorView startAnimating];
    
    // 1
    if (! [CLLocationManager locationServicesEnabled]) {
        NSLog(@"未开启定位服务, 请开启定位服务定位您所在城市.");
    }
    // 2
    else if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    // 3
    else {
        
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //    if (self.isFirstUpdate) {
    //        // 4
    //        self.isFirstUpdate = NO;
    //        return;
    //    }
    
    // 5
    _checkLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:_checkLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (! error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                
                // 获取城市
                NSString *city = placemark.locality;
                if (! city) {
                    // 6
                    city = placemark.administrativeArea;
                }
                [self locationResult:city];
                self.state = JYLocationStateSucces;
            } else if ([placemarks count] == 0) {
                NSLog(@"定位城市失败");
                [self locationResult:@"定位失败"];
                self.state = JYLocationStateError;
            }
        } else {
            NSLog(@"请检查您的网络");
            [self locationResult:@"定位失败"];
           self.state = JYLocationStateError;
        }
    }];
    [_locationManager stopUpdatingLocation];
}

- (void)locationResult:(NSString *)str
{
    self.cityBtn.hidden = NO;
    [self.cityBtn setTitle:str forState:UIControlStateNormal];
    self.label.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

+ (NSString *)delectedSubStringOfStr:(NSString *)str
{
    NSRange range = [str rangeOfString:@"市"];
    if (range.length) {
        return [str substringWithRange:NSMakeRange(0, range.location)];
    } else {
        return str;
    }
}

@end
