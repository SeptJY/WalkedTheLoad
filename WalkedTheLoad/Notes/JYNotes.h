//
//  JYNotes.h
//  WalkedTheLoad
//
//  Created by Sept on 16/7/29.
//  Copyright © 2016年 丶九月. All rights reserved.
//

#ifndef JYNotes_h
#define JYNotes_h

/**
   如何修改状态栏的颜色
   A.在vc中重写vc的preferredStatusBarStyle方法
     1.UIStatusBarStyleDefault   ---> 黑色
     2.UIStatusBarStyleLightContent   ---> 白色
   -(UIStatusBarStyle)preferredStatusBarStyle
   {
       return UIStatusBarStyleDefault;
   }
 
   当在有导航栏的控制器中这个就不管用了，但导航栏如果隐藏了还是有用的，在不隐藏导航栏的情况下有两种方法修改状态栏颜色
   第一种：设置navbar的barStyle 属性会影响status bar 的字体和背景色
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack
 
   第二种：
     自定义一个nav bar的子类，在这个子类中重写preferredStatusBarStyle方法：
     
     MyNav* nav = [[MyNav alloc] initWithRootViewController:vc];
     
     self.window.rootViewController = nav;
     
     @implementation MyNav
     
     - (UIStatusBarStyle)preferredStatusBarStyle
     {
     
     UIViewController* topVC = self.topViewController;
     
     return [topVC preferredStatusBarStyle];
     
     }
 */


#endif /* JYNotes_h */
