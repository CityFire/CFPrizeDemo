//
//  ThemeButton.h
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

// normal下显示的图片名称
@property(nonatomic,copy) NSString *imgName;

// 高亮状态下显示的图片名称
@property(nonatomic,copy) NSString *highlightImgName;

// normal下得背景图片
@property(nonatomic,copy) NSString *backImgName;

// 高亮状态下显示的背景图片名称
@property(nonatomic,copy) NSString *backHighlightImgName;

// 标题的颜色key
@property(nonatomic,copy) NSString *colorKeyName;

@end
