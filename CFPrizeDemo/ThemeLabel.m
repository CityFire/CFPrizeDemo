//
//  ThemeLabel.m
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (void)dealloc
{
    self.colorKeyName = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNofitication object:nil];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNofitication object:nil];

}

- (void)themeChangeAction:(NSNotification *)notification
{
    [self loadColor];
}

// 覆写方法，重新刷新数据
- (void)setColorKeyName:(NSString *)colorKeyName
{
    if (colorKeyName != _colorKeyName) {
        [_colorKeyName release];
        _colorKeyName = [colorKeyName retain];
       [self loadColor];
    }
}

- (void)loadColor
{
    UIColor *fontColor = [[ThemeManager shareInstance] getFontColor:self.colorKeyName];
    self.textColor = fontColor;
}

@end
