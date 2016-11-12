//
//  UIView+FirstResponder.h
//  CFPrizeDemo
//
//  Created by wjc on 16/11/11.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CFFirstResponder)

- (UIViewController *)cf_viewController;

// 递归查找view的nextResponder，知道找到类型为class的Responder 返回第一个满足类型为class的UIResponder
- (UIResponder *)cf_nextResponderWithClass:(Class)class;

// 查找firstResponder
- (UIResponder *)cf_findFirstResponder;

@end
