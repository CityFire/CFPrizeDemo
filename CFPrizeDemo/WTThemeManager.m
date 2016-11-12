//
//  WTThemeManager.m
//  tutuapp
//
//  Created by wjc on 13-10-9.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#define IsDeviceVersionIOS7 ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
// 是否高清屏
#define isDeviceRetina (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO : [UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width > 320 : NO)

#import "WTThemeManager.h"

@implementation WTThemeManager

+ (UIFont *)getFont:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIColor *)getNavColor {
    if (IsDeviceVersionIOS7) {
        return [UIColor colorWithRed:0.93333 green:0.93333 blue:0.93333 alpha:0.9];
    }
    return [UIColor colorWithRed:0.93333 green:0.93333 blue:0.93333 alpha:1.0];
}

+ (UIColor *)getBackgroundColor {
    return [UIColor colorWithRed:0.9647 green:0.9647 blue:0.9647 alpha:1.0];
}

+ (UIColor *)getCommonBtnColor {
    return [WTThemeManager getGlobalGreenColor];
}

+ (UIColor *)getCellSelectedColor {
    return [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
}

+ (UIColor *)getGlobalGreenColor {
    return [UIColor colorWithRed:0.08235 green:0.70588 blue:0.45490 alpha:1.0];
}

+ (UIColor *)getGlobalDeepBlackColor {
    return [UIColor colorWithRed:0.09020 green:0.09020 blue:0.09020 alpha:1.0];
}

+ (CGFloat)separatorHeiht {
    return isDeviceRetina ? 0.5 : 1.0;
}

+ (UIColor *)separatorColor {
    return [UIColor colorWithRed:0.7529 green:0.7529 blue:0.7529 alpha:1.0];
}

@end
