//
//  UIViewController+Toast.h
//  CFPrizeDemo
//
//  Created by wjc on 16/11/12.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (CFToast)

@property (nonatomic) UIView *cf_tipView;

@property (nonatomic, readonly) MBProgressHUD *cf_hud;

// 加载提示
- (void)showLoading:(BOOL)show;
// 显示hud加载提示
- (void)showHud:(NSString *)title;
// 显示hud加载提示，delay后隐藏
- (void)showHud:(NSString *)title afterDelay:(CGFloat)delay;
// 两种隐藏hud的方式
- (void)hideHud; // 直接隐藏
- (void)hideHudWithComplete:(NSString *)title; // 隐藏之前显示操作完成的提示

@end
