//
//  ThemeCell.h
//  tutuapp
//
//  Created by wjc on 13-10-5.
//  Copyright (c) 2013年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImage.h"
#import "ThemeLabel.h"

@interface ThemeCell : UITableViewCell

@property(nonatomic,retain) ThemeImage *imgView;
@property(nonatomic,retain) ThemeLabel *txLabel;
@property(nonatomic,retain) ThemeLabel *dtLabel;

@end
