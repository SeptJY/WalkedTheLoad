//
//  JYAllCity.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//
// 索引城市列表

#import "JYLocation.h"

@interface JYAllCity : JYLocation

@property (copy, nonatomic) NSString *divisionStr;

@property (assign, nonatomic) BOOL isOpen;

@property (assign, nonatomic) CGFloat lat;

@property (assign, nonatomic) CGFloat lng;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *pinyin;

@end
