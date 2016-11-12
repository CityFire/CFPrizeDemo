//
//  WTWheelView.h
//  tutuapp
//
//  Created by wjc on 14/11/12.
//  Copyright © 2014年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTWheelView : UIView

+ (instancetype)wheelView;

// 核心动画不能改变图层的属性
- (void)startAnimation;

- (void)stopAnimation;

@end
