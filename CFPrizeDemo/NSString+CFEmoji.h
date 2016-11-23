//
//  NSString+CFEmoji.h
//  WeiPhone
//
//  Created by wjc on 14/7/12.
//  Copyright (c) 2014年 CityFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CFEmoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)cf_emojiWithIntCode:(NSInteger)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)cf_emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)cf_isEmoji;

@end
