//
//  ThemeManager.h
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSNotificationName const kThemeDidChangeNofitication;

@interface ThemeManager : NSObject

// 当前的主题名字
@property(nonatomic,copy) NSString *themeName;

// 主题的映射字典
@property(nonatomic,retain) NSDictionary *themeConfig;

// font字典配置文件
@property(nonatomic,retain) NSDictionary *fontConfig;

+ (ThemeManager *)shareInstance;

// 获取当前主题下的图片数据
- (UIImage *)getThemeImage:(NSString *)imageName;

// 获取字体的颜色
- (UIColor *)getFontColor:(NSString *)colorName;

- (NSString *)getLinkColor:(NSString *)fontName;

// 保存主题
- (void)saveTheme;

@end
