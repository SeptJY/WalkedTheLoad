//
//  JYDataManager.m
//  WalkedTheLoad
//
//  Created by Sept on 16/7/30.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#import "JYDataManager.h"

@implementation JYDataManager

static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        _instace = [super allocWithZone:zone];
    });
    
    return _instace;
}

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    
    return _instace;
}

- (instancetype)copeWithZone:(NSZone *)zone
{
    return _instace;
}

@end
