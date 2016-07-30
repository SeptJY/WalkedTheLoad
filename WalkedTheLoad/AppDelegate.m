//
//  AppDelegate.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

#import "JYHomeController.h"

@interface AppDelegate () <CLLocationManagerDelegate>
{
    //定位
    CLLocation *_checkLocation;//用于保存位置信息
}

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:[[JYHomeController alloc] init]];
    
    self.window.rootViewController = navCtl;
    
    [self.window makeKeyAndVisible];
    
    [self findCurrentLocation];
    
    return YES;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        
    }
    return _locationManager;
}


- (void)findCurrentLocation {
    
    // 1
    if (! [CLLocationManager locationServicesEnabled]) {
        NSLog(@"未开启定位服务, 请开启定位服务定位您所在城市.");
    }
    // 2
    else if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
    }
    // 3
    else {
        
        [_locationManager requestAlwaysAuthorization];
        [_locationManager startUpdatingLocation];
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
                [JYDataManager sharedManager].currentCity = city;
                NSLog(@"%@", [JYDataManager sharedManager].currentCity);
            } else if ([placemarks count] == 0) {
                NSLog(@"定位城市失败");
            }
        } else {
            NSLog(@"请检查您的网络");
        }
    }];
    [_locationManager stopUpdatingLocation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
