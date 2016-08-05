//
//  JYCityList.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYCityList.h"

@implementation JYCityList

// 这个方法对比上面的2个方法更加没有侵入性和污染，因为不需要导入Status和Ad的头文件
+ (NSDictionary *)objectClassInArray{
    return @{
             @"arealist" : @"JYArealist"
             };
}

@end
