//
//  ThemeCell.m
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import "ThemeCell.h"
#import "ThemeManager.h"

@implementation ThemeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNofitication object:nil];
    }
    return self;
}

- (void)_initViews
{
    _imgView = [[ThemeImage alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
    _txLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(_imgView.right+5, 11, 200, 20)];
    _dtLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(180, 11, 95, 20)];
    
    _txLabel.font = [UIFont systemFontOfSize:15];
    _txLabel.backgroundColor = [UIColor clearColor];
    _txLabel.colorKeyName = @"More_Item_Text_color";
    
    _dtLabel.font = [UIFont systemFontOfSize:13];
    _dtLabel.textAlignment = NSTextAlignmentRight;
    _dtLabel.backgroundColor = [UIColor clearColor];
   _dtLabel.colorKeyName = @"More_Item_Text_color";
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_txLabel];
    [self.contentView addSubview:_dtLabel];
    
}

- (void)themeChangeAction
{
    self.backgroundColor = [[ThemeManager shareInstance] getFontColor:@"More_Item_color"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self themeChangeAction];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
