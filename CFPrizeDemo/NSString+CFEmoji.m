//
//  NSString+CFEmoji.m
//  WeiPhone
//
//  Created by wjc on 14/7/12.
//  Copyright (c) 2014年 CityFire. All rights reserved.
//

#import "NSString+CFEmoji.h"

#define CF_EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Emoji)

+ (NSString *)cf_emojiWithIntCode:(NSInteger)intCode {
    NSInteger symbol = CF_EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

+ (NSString *)cf_emojiWithStringCode:(NSString *)stringCode {
    char *charCode = (char *)stringCode.UTF8String;
    NSInteger intCode = strtol(charCode, NULL, 16);
    return [self cf_emojiWithIntCode:intCode];
}

// 判断是否是emoji表情
- (BOOL)cf_isEmoji {
     BOOL returnValue = NO;
         
     const unichar hs = [self characterAtIndex:0];
     // surrogate pair
     if (0xd800 <= hs && hs <= 0xdbff) {
         if (self.length > 1) {
             const unichar ls = [self characterAtIndex:1];
             const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
             if (0x1d000 <= uc && uc <= 0x1f77f) {
                 returnValue = YES;
             }
         }
     }
     else if (self.length > 1) {
         const unichar ls = [self characterAtIndex:1];
         if (ls == 0x20e3) {
             returnValue = YES;
         }
     }
     else {
         // non surrogate
         if (0x2100 <= hs && hs <= 0x27ff) {
             returnValue = YES;
         }
         else if (0x2B05 <= hs && hs <= 0x2b07) {
             returnValue = YES;
         }
         else if (0x2934 <= hs && hs <= 0x2935) {
             returnValue = YES;
         }
         else if (0x3297 <= hs && hs <= 0x3299) {
             returnValue = YES;
         }
         else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
             returnValue = YES;
         }
     }
    
    return returnValue;
}

@end
