//
//  UIView+CFHitTest.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/13.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "UIView+CFHitTest.h"
#import <objc/runtime.h>

@implementation UIView (CFHitTest)

const static NSString *CFHitTestViewBlockKey = @"CFHitTestViewBlockKey";
const static NSString *CFPointInsideBlockKey = @"CFPointInsideBlockKey";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(hitTest:withEvent:)), class_getInstanceMethod(self, @selector(cf_hitTest:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)), class_getInstanceMethod(self, @selector(cf_pointInside:withEvent:)));
}

- (UIView *)cf_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[hitTest:withEvent:]", spaces, NSStringFromClass(self.class));
    UIView *deliveredView = nil;
    // 如果有hitTestBlock的实现，则调用block
    if (self.hitTestBlock) {
        BOOL returnSuper = NO;
        deliveredView = self.hitTestBlock(point, event, &returnSuper);
        if (returnSuper) {
            deliveredView = [self cf_hitTest:point withEvent:event];
        }
    } else {
        deliveredView = [self cf_hitTest:point withEvent:event];
    }
//    NSLog(@"%@%@:[hitTest:withEvent:] Result:%@", spaces, NSStringFromClass(self.class), NSStringFromClass(deliveredView.class));
    return deliveredView;
}

- (BOOL)cf_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[pointInside:withEvent:]", spaces, NSStringFromClass(self.class));
    BOOL pointInside = NO;
    if (self.pointInsideBlock) {
        BOOL returnSuper = NO;
        pointInside =  self.pointInsideBlock(point, event, &returnSuper);
        if (returnSuper) {
            pointInside = [self cf_pointInside:point withEvent:event];
        }
    }
    else {
        pointInside = [self cf_pointInside:point withEvent:event];
    }
    return pointInside;
}

#pragma mark - setter/getter methods
- (void)setHitTestBlock:(CFHitTestViewBlock)hitTestBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(CFHitTestViewBlockKey), hitTestBlock, OBJC_ASSOCIATION_COPY);
}

- (CFHitTestViewBlock)hitTestBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(CFHitTestViewBlockKey));
}

- (void)setPointInsideBlock:(CFPointInsideBlock)pointInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(CFPointInsideBlockKey), pointInsideBlock, OBJC_ASSOCIATION_COPY);
}

- (CFPointInsideBlock)pointInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(CFPointInsideBlockKey));
}

@end
