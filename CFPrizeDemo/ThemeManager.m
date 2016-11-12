//
//  ThemeManager.m
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import "ThemeManager.h"

NSNotificationName const kThemeDidChangeNofitication = @"kThemeDidChangeNofitication";

#define kDefaultThemeName @"猫爷"
#define kThemeName @"themeName"

static  ThemeManager *instace = nil;

@implementation ThemeManager

+ (ThemeManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[[self class] alloc] init];
    });
    return instace;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        // 主题映射的字典
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:themePath];
        
        // 主题的名字
        self.themeName = kDefaultThemeName;
        
        // 判断本地是否存储
        NSString *saveThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (saveThemeName.length > 0 ) {
            self.themeName = saveThemeName;
        }
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName retain];
        // 读取当前主题下得字体配置文件
        NSString *themePath = [self themePaths];
        NSString *fontPath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.fontConfig = [NSDictionary dictionaryWithContentsOfFile:fontPath];
    }
}

// 获取当前主题下得图片数据
- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    // 当前主题的路径
    NSString *themePath = [self themePaths];
    // 将图片名拼接到主题包路径后面
    NSString *imgPath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    return image;
}

// 获取当前主题的路径
- (NSString *)themePaths
{
    // 1.获取程序包得路径
    NSString *rootPath = [[NSBundle mainBundle]resourcePath];
    
    // 2.获取当前主题对应的子路径
    NSString *themePath = [self.themeConfig objectForKey:self.themeName];
    
    // 3.拼接路径
    NSString *path = [rootPath stringByAppendingPathComponent:themePath];
    
    return path;
}

// 获取当前主题下字体对应的颜色
- (UIColor *)getFontColor:(NSString *)colorName
{
    if (colorName.length == 0) {
        return nil;
    }
    NSDictionary *rgDic = [self.fontConfig objectForKey:colorName];
    float r = [[rgDic objectForKey:@"R"]floatValue];
    float g = [[rgDic objectForKey:@"G"]floatValue];
    float b = [[rgDic objectForKey:@"B"]floatValue];
    
   UIColor *color = rgba(r, g, b, 1);
    return color;
}

// 链接颜色
- (NSString *)getLinkColor:(NSString *)fontName
{
    if (fontName.length == 0) {
        return nil;
    }
    
    NSDictionary *rgbDic = [self.fontConfig objectForKey:fontName];
    int r = [[rgbDic objectForKey:@"R"]intValue];
    int g = [[rgbDic objectForKey:@"G"]intValue];
    int b = [[rgbDic objectForKey:@"B"]intValue];
    
    NSString *colorText = [NSString stringWithFormat:@"#%02x%02x%02x",r,g,b];
    
    return colorText;
}

// 保存主题
- (void)saveTheme
{
    [[NSUserDefaults standardUserDefaults]setObject:_themeName forKey:kThemeName];
    // 设置同步
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
