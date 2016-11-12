//
//  WTAward.h
//  tutuapp
//
//  Created by weiphone-ued on 14-10-16.
//  Copyright (c) 2014年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTAward : NSObject

@property (nonatomic, strong) NSString *Aid;
@property (nonatomic, strong) NSString *awardCount;  // 奖品 萝卜币币数
@property (nonatomic, strong) NSString *awardUrl;    // 奖品图片
@property (nonatomic, strong) UIImage *awardImage;    // 奖品图片
@property (nonatomic, strong) NSString *prizeDesc;   // 中奖描述
@property (nonatomic, strong) NSString *awardName;   // 奖品名

@end

@interface WTHeroPrize : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *heroDesc;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createDate;

@end

@interface WTCoin : NSObject

@property (nonatomic, strong) NSString *totalCoin;
@property (nonatomic, strong) NSString *consumeCoin;

@end
