//
//  UIView+FirstResponder.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/11.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "UIView+CFFirstResponder.h"

@implementation UIView (CFFirstResponder)

- (UIViewController *)cf_viewController {
    return (UIViewController *)[self cf_nextResponderWithClass:UIViewController.class];
}

- (UIResponder *)cf_nextResponderWithClass:(Class)class {
    UIResponder *nextResponder = self;
    while (nextResponder) {
        nextResponder = nextResponder.nextResponder;
        if ([nextResponder isKindOfClass:class]) {
            return nextResponder;
        }
    }
    return nil;
}

- (UIResponder *)cf_findFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView cf_findFirstResponder];
        if (responder) {
            return responder;
        }
    }
    return nil;
}

@end
