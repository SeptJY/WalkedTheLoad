//
//  JYDefine.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#ifndef JYDefine_h
#define JYDefine_h

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define JYMainColor setColor(77, 199, 248)

// 颜色设置
#define setColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define setFont(r) [UIFont systemFontOfSize:(r)]
#define setBoldFont(r) [UIFont boldSystemFontOfSize:(r)]

#ifdef DEBUG // 调试状态, 打开LOG功能
#define JYLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define JYLog(...)
#endif

#endif /* JYDefine_h */
