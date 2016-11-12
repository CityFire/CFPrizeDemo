//
//  WTLotteryButton.m
//  WTLotteryDemo
//
//  Created by wjc on 15/2/12.
//  Copyright (c) 2015年 WeiPhone. All rights reserved.
//

#import "WTLotteryButton.h"

@interface WTLotteryButton ()

@property UIImageView *titleImageView;
@property UILabel *label;

@end

@implementation WTLotteryButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.99 green:0.54 blue:0.16 alpha:1];
        
        float height = frame.size.height;
        float labelWidth = 70;
 
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
        _label.font = [UIFont boldSystemFontOfSize:15];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentRight;
        _label.text = @"开始抽奖";
        [self addSubview:_label];
        
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(labelWidth+5, (height-15)/2, 30, 15)];
        _titleImageView.image = [UIImage imageNamed:@"lottery4"];
        [self addSubview:_titleImageView];
        
    }
    return self;
}

@end
