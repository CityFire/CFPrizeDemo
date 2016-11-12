//
//  UIViewController+Toast.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/12.
//  Copyright © 2016年 CityFire. All rights reserved.
//  ToastDemo 没有进一步的扩展

#import "UIViewController+CFToast.h"
#import <objc/runtime.h>
#import "ThemeLabel.h"

// 获取物理屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation UIViewController (CFToast)

// 加载提示
- (void)showLoading:(BOOL)show {
    UIView *_tipView = objc_getAssociatedObject(self, @selector(cf_tipView));
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreenHeight-20-44)/2, kScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        // 1.loading视图
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        // 2.加载提示的label
        ThemeLabel *loadLabel = [[ThemeLabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载…";
        loadLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor = [UIColor blackColor];
        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        self.cf_tipView = _tipView;
        
        loadLabel.left = (kScreenWidth - loadLabel.width)/2;
        activity.right = loadLabel.left;
    }
    
    if (show) {
        [self.view addSubview:_tipView];
    }
    else {
        if (_tipView.superview) {
            [_tipView removeFromSuperview];
        }
    }
    
}

// 显示hud加载提示
- (void)showHud:(NSString *)title
{
    MBProgressHUD *_cf_hud = objc_getAssociatedObject(self, @selector(cf_tipView));
    if (_cf_hud == nil) {
        _cf_hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    _cf_hud.labelText = title;
    _cf_hud.dimBackground = YES;
    self.cf_hud = _cf_hud;
}

// 显示hud加载提示，delay后隐藏
- (void)showHud:(NSString *)title afterDelay:(CGFloat)delay {
    [self showHud:title];
    // 延迟隐藏
    [self.cf_hud hide:YES afterDelay:delay];
}

// 两种隐藏hud的方式
- (void)hideHud
{
    // 直接隐藏
    [self.cf_hud hide:YES];
    
}

- (void)hideHudWithComplete:(NSString *)title {
    // 隐藏之前显示操作完成的提示
    self.cf_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    // 显示模式为自定义视图模式
    self.cf_hud.mode = MBProgressHUDModeCustomView;
    self.cf_hud.labelText = title;
    
    // 延迟隐藏
    [self.cf_hud hide:YES afterDelay:1.5];
}

#pragma mark - getter/setter
- (UIView *)cf_tipView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCf_tipView:(UIView *)cf_tipView {
    objc_setAssociatedObject(self, @selector(cf_tipView), cf_tipView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)cf_hud {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCf_hud:(MBProgressHUD *)cf_hud {
    objc_setAssociatedObject(self, @selector(cf_hud), cf_hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
