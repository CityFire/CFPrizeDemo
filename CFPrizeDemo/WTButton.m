//
//  WTButton.m
//  tutuapp
//
//  Created by wjc on 14/11/12.
//  Copyright © 2014年 WeiPhone. All rights reserved.
//

#import "WTButton.h"

@implementation WTButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
