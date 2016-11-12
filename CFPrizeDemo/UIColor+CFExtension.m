//
//  UIColor+Extension.m
//  Wealth88
//
//  Created by wjc on 15/5/26.
//  Copyright (c) 2015年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import "UIColor+CFExtension.h"

@implementation UIColor (CFExtension)

#pragma mark  十六进制颜色
+ (UIColor *)cf_colorWithHexString:(NSString *)hexColorString{
    return [self cf_colorWithHexColorString:hexColorString alpha:1.0f];
}

#pragma mark  十六进制颜色
+ (UIColor *)cf_colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha{
    
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
    
    NSString *pureHexString = [[hexColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (pureHexString.length != 6) {
        return [UIColor whiteColor];
    }
    
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[pureHexString substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    
    [[NSScanner scannerWithString:[pureHexString substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    
    [[NSScanner scannerWithString:[pureHexString substringWithRange:range]]scanHexInt:&blue];
    
    UIColor *color = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
    
    return color;
}

+ (UIColor *)cf_hexColorWithString:(NSString *)string
{
    return [UIColor cf_hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)cf_hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


/**
 *  获取颜色图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)cf_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

/**
 *  获取颜色图片
 *
 *  @param color 颜色
 *  @param rect 返回图片大小
 *
 *  @return 图片
 */
+ (UIImage *)cf_imageWithColor:(UIColor *)color inRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
