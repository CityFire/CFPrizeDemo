//
//  UIColor+Extension.h
//  Wealth88
//
//  Created by wjc on 15/5/26.
//  Copyright (c) 2015年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define hexColor(colorV) [UIColor cf_colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor cf_colorWithHexColorString:@#colorV alpha:a];

@interface UIColor (CFExtension)

/**
 *  十六进制颜色
 */
+ (UIColor *)cf_colorWithHexString:(NSString *)hexColorString;

/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)cf_colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

/**
 *  获取颜色图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)cf_imageWithColor:(UIColor *)color;

/**
 *  获取颜色图片
 *
 *  @param color 颜色
 *  @param rect 返回图片大小
 *
 *  @return 图片
 */
+ (UIImage *)cf_imageWithColor:(UIColor *)color inRect:(CGRect)rect;

@end
