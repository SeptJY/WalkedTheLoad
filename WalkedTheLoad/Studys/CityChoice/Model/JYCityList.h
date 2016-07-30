//
//  JYCityList.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

// 市级区域

#import "JYLocation.h"

@interface JYCityList : JYLocation

@property (copy, nonatomic) NSString *cityName;

@property (strong, nonatomic) NSArray *arealist;

@end
