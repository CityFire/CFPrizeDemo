//
//  UILabel+Compatibility.m
//  Wealth88
//
//  Created by wjc on 15/8/11.
//  Copyright (c) 2015年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import "UILabel+Compatibility.h"
#import <objc/runtime.h>

@implementation UILabel (Compatibility)

+ (void)load {
    // 先判断系统版本，尽量减少Rumtime的作用范围
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0f) {
        // Method Swizzling
        Method oriMethod = class_getInstanceMethod(self, @selector(initWithFrame:));
        Method newMethod = class_getInstanceMethod(self, @selector(compatible_initWithFrame:));
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

- (id)compatible_initWithFrame:(CGRect)frame {
    id newSelf = [self compatible_initWithFrame:frame];
    // 设置背景色透明
    ((UILabel *)newSelf).backgroundColor = [UIColor clearColor];
    return newSelf;
}

/**
 * 解析Property的Attributed字符串，参考Stackoverflow
 */
static const char *getPropertyType(objc_property_t property) {
    // 获取一个Property的详细类型表达字符串
    const char *attributes = property_getAttributes(property);
    
    NSLog(@"%s", attributes);
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        // 非对象类型
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // 利用NSData复制一份字符串
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
            // 纯id类型
        } else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            return "id";
            // 对象类型
        } else if (attribute[0] == 'T' && attribute[1] == '@') {
            return (const char *) [[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

/**
 * 给对象的属性设置默认值
 */
void checkEntity(NSObject *object) {
    // 不同类型的字符串表示，目前只是简单检查字符串、数字、数组
    static const char *CLASS_NAME_NSSTRING;
    static const char *CLASS_NAME_NSNUMBER;
    static const char *CLASS_NAME_NSARRAY;
    
    //初始化类型常量
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // "NSString"
        CLASS_NAME_NSSTRING = NSStringFromClass([NSString class]).UTF8String;
        // "NSNumber
        CLASS_NAME_NSNUMBER = NSStringFromClass([NSNumber class]).UTF8String;
        // "NSArray"
        CLASS_NAME_NSARRAY = NSStringFromClass([NSArray class]).UTF8String;
    });
    
    @try {
        unsigned int outCount, i;
        // 包含所有Property的数组
        objc_property_t *properties = class_copyPropertyList([object class], &outCount);
        
        // 遍历每个property
        for (i = 0; i < outCount; i++) {
            // 取出对应property
            objc_property_t property = properties[i];
            // 获取Property对应的变量名
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            // 获取property的类型名
            const char *propertyTypeName = getPropertyType(property);
            // 获取Property的值
            id propertyValue = [object valueForKey:propertyName];
            
            // 值为空，才设置默认值
            if (!propertyValue) {
                // NSString
                if (strncmp(CLASS_NAME_NSSTRING, propertyTypeName, strlen(CLASS_NAME_NSSTRING)) == 0) {
                    [object setValue:@"" forKey:propertyName];
                }
                
                // NSNumber
                if (strncmp(CLASS_NAME_NSNUMBER, propertyTypeName, strlen(CLASS_NAME_NSNUMBER)) == 0) {
                    [object setValue:@0 forKey:propertyName];
                }
                
                // NSArray
                if (strncmp(CLASS_NAME_NSARRAY, propertyTypeName, strlen(CLASS_NAME_NSARRAY)) == 0) {
                    [object setValue:@[] forKey:propertyName];
                }
            }
        }
        // 别忘了释放数组
        free(properties);
    }
    @catch (NSException *exception) {
        NSLog(@"Check Entity Exception: %@", [exception description]);
    }
    @finally {
        
    }
    
}

@end
