//
//  ThemeButton.m
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (void)dealloc
{
//    [_imgName release];
//    [_highlightImgName release];
//    [_backHighlightImgName release];
//    [_backImgName release];
    self.imgName = nil;
    self.highlightImgName = nil;
    self.colorKeyName = nil;
    self.backHighlightImgName = nil;
    self.backImgName = nil;
    
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNofitication object:nil];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initViews];
}

- (void)_initViews
{
    // 监听主题更换的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNofitication object:nil];
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)themeChangeAction:(NSNotification *)notification
{
    [self loadImage];
}

- (void)loadImage
{
    ThemeManager  *themeManager = [ThemeManager shareInstance];
    
    UIImage *imgName = [themeManager getThemeImage:self.imgName];
    UIImage *highlightImgName = [themeManager getThemeImage:self.highlightImgName];
    UIImage *backImg = [themeManager getThemeImage:self.backImgName];
    UIImage *backHighImg = [themeManager getThemeImage:self.backHighlightImgName];
    
    // 修改标题颜色
    UIColor *titleColor = [themeManager getFontColor:self.colorKeyName];
    
    [self setImage:imgName forState:UIControlStateNormal];
    [self setImage:highlightImgName forState:UIControlStateHighlighted];
    [self setBackgroundImage:backImg forState:UIControlStateNormal];
    [self setBackgroundImage:backHighImg forState:UIControlStateHighlighted];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

// 修改时调用下面方法  重新加载图片
- (void)setImgName:(NSString *)imgName
{
    if (_imgName != imgName) {
        [_imgName release];
        _imgName = [imgName copy];
        
        [self loadImage];
    }
}

- (void)setHighlightImgName:(NSString *)highlightImgName
{
    if (_highlightImgName!= highlightImgName) {
        [_highlightImgName release];
        _highlightImgName = [highlightImgName copy];
         [self loadImage];
    }
   
    
}

- (void)setBackImgName:(NSString *)backImgName
{
    if (_backImgName != backImgName) {
        [_backImgName release];
        _backImgName = [backImgName copy];
        [self loadImage];
    }
}

- (void)setBackHighlightImgName:(NSString *)backHighlightImgName
{
    if (_backHighlightImgName != backHighlightImgName) {
        [_backHighlightImgName release];
        _backHighlightImgName = [backHighlightImgName copy];
    
        [self loadImage];
    }
}

- (void)setColorKeyName:(NSString *)colorKeyName
{
   if(_colorKeyName != colorKeyName) {
       [_colorKeyName release];
       _colorKeyName = [colorKeyName retain];
       
       UIColor *titlColor = [[ThemeManager shareInstance] getFontColor:self.colorKeyName];
       [self setTitleColor:titlColor forState:UIControlStateNormal];
   }
}

@end
