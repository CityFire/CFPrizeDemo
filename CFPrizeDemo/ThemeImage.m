//
//  ThemeImage.m
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import "ThemeImage.h"
#import "ThemeManager.h"

@implementation ThemeImage

- (void)dealloc
{
    self.imgName = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kThemeDidChangeNofitication object:nil];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNofitication object:nil];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 主题切换通知
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNofitication object:nil];
}

#pragma mark -notification
- (void)themeChangeAction:(NSNotification *)notification
{
    [self loadImage];
}

- (void)loadImage
{
    UIImage *image = [[ThemeManager shareInstance]getThemeImage:self.imgName];
    /* 
     方法描述：
         当图片要被拉伸的时候，设置拉伸点，防止图片被拉坏
     */
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    
    self.image = image;
}

// 覆写image的set方法，重新刷新数据
- (void)setImgName:(NSString *)imgName
{
    if (_imgName != imgName) {
        [_imgName release];
        _imgName = [imgName retain];
        [self loadImage];
    }
}

@end
