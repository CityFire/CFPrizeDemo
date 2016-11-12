//
//  NSNull+InternalNullExtention.m
//  Wealth88
//
//  Created by wjc on 15/7/3.
//  Copyright (c) 2015年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"

@implementation NSNull (InternalNullExtention)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    [self doesNotRecognizeSelector:aSelector];
}

@end
