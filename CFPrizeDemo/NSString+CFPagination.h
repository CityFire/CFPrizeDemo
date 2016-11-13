//
//  NSString+CFPagination.h
//  CFPrizeDemo
//
//  Created by wjc on 16/11/13.
//  Copyright © 2016年 CityFire. All rights reserved.
//  对文本进行分页

#import <Foundation/Foundation.h>

@interface NSString (CFPagination)

- (NSArray *)cf_paginationWithAttributes:(NSDictionary *) attributes constrainedToSize:(CGSize) size;

@end
