//
//  JYDataManager.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYDataManager : NSObject

/** 当前城市 */
@property (copy, nonatomic) NSString *currentCity;

+ (instancetype)sharedManager;

@end
