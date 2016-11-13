//
//  NSString+CFPagination.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/13.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "NSString+CFPagination.h"
#import <CoreText/CoreText.h>

@implementation NSString (CFPagination)

/**
 * @abstract 根据指定的大小,对字符串进行分页,计算出每页显示的字符串区间(NSRange)
 *
 * @param    attributes  分页所需的字符串样式,需要指定字体大小,行间距等。iOS6.0以上请参见UIKit中NSAttributedString的扩展,iOS6.0以下请参考CoreText中的CTStringAttributes.h
 * @param    size        需要参考的size。即在size区域内
 */
- (NSArray *)cf_paginationWithAttributes:(NSDictionary *) attributes constrainedToSize:(CGSize) size  {
    NSMutableArray *resultRange = [NSMutableArray arrayWithCapacity:5];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 构造NSAttributedString
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
//    以下方法耗时 基本再 0.5s 以内
//    NSDate * date = [NSDate date];
    NSInteger rangeIndex = 0;
    do {
        NSInteger length = MIN(500, attributedString.length - rangeIndex);
        NSAttributedString *childString = [attributedString attributedSubstringFromRange:NSMakeRange(rangeIndex, length)];
        CTFramesetterRef childFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) childString);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frame = CTFramesetterCreateFrame(childFramesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
        
        CFRange range = CTFrameGetVisibleStringRange(frame);
        NSRange r = {rangeIndex, range.length};
        if (r.length > 0) {
            [resultRange addObject:NSStringFromRange(r)];
        }
        rangeIndex += r.length;
        CFRelease(frame);
        CFRelease(childFramesetter);
    } while (rangeIndex < attributedString.length && attributedString.length > 0);
//    NSTimeInterval millionSecond = [[NSDate date] timeIntervalSinceDate:date];
//    // NSLog(@"耗时 %lf", millionSecond);
    return resultRange;
}

@end
