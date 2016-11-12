//
//  UITableViewCell+Compatibility.m
//  Wealth88
//
//  Created by wjc on 15/8/11.
//  Copyright (c) 2015年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import "UITableViewCell+Compatibility.h"
#import <objc/runtime.h>

@implementation UITableViewCell (Compatibility)

+ (void)load {
    // 编译时判断SDK
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    // 运行时判断系统版本
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0f) {
        Method newMethod = class_getInstanceMethod(self, @selector(compatible_setSeparatorInset:));
        // 增加Dummy方法
        class_addMethod(self, @selector(setSeparatorInset:), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    }
#endif
}

// setSeparatorInset: 的Dummy方法
- (void)compatible_setSeparatorInset:(UIEdgeInsets) inset {
    // 空方法都可以，只是为了接收setSeparatorInset:消息。
}

@end
