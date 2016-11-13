//
//  UIButton+EnlargeTouchArea.h
//  Wealth88
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 CityFire. All rights reserved.
//  对UIButton扩大Touch区域范围

#import <UIKit/UIKit.h>

@interface UIButton (CFEnlargeTouchArea)

- (void)cf_setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                            bottom:(CGFloat)bottom
                                left:(CGFloat)left;

@end
