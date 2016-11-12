//
//  WTThemeManager.h
//  tutuapp
//
//  Created by wjc on 13-10-9.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTThemeManager : NSObject

+ (UIFont *)getFont:(CGFloat)fontSize;

+ (UIColor *)getNavColor;

+ (UIColor *)getBackgroundColor;

+ (UIColor *)getCommonBtnColor;

+ (UIColor *)getCellSelectedColor;

+ (UIColor *)getGlobalGreenColor;

+ (UIColor *)getGlobalDeepBlackColor;

+ (CGFloat)separatorHeiht;

+ (UIColor *)separatorColor;

@end
