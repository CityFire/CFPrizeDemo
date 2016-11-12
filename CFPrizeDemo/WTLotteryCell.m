//
//  WTLotteryCell.m
//  WTLotteryDemo
//
//  Created by wjc on 15/2/12.
//  Copyright (c) 2015年 WeiPhone. All rights reserved.
//

#import "WTLotteryCell.h"

@interface WTLotteryCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *titleImageView;

@end

@implementation WTLotteryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float height = frame.size.height;
        float imageWidth = 17;
        float orginX = 6;

        self.image = [UIImage imageNamed:@"lottery3"];
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(orginX, (height-imageWidth)/2, imageWidth, imageWidth)];
        _titleImageView.image = [UIImage imageNamed:@"lottery1"];
        [self addSubview:_titleImageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(orginX+imageWidth, (height-imageWidth)/2, imageWidth, imageWidth)];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
        [self addSubview:_label];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _label.text = text;
}

- (void)setTextColor:(UIColor *)color {
    _label.textColor = color;
}

@end
