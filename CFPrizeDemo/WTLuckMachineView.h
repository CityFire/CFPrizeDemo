//
//  WTLuckMachineView.h
//  tutuapp
//
//  Created by wjc on 14-11-12.
//  Copyright (c) 2014年 WeiPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTLuckMachineViewDelegate;

@interface WTLuckMachineView : UIView

@property (nonatomic) NSInteger ownCarrot;
@property (nonatomic) NSInteger consumerCarror;
@property (nonatomic) NSInteger rollCount;
@property (nonatomic, weak) id<WTLuckMachineViewDelegate>delegate;

- (void)setDatas:(NSArray *)datas;

// 开始
- (void)startSliding;
// 结束
- (void)stopSliding;
- (void)setPoints:(NSArray *)points;

@end

@protocol WTLuckMachineViewDelegate <NSObject>

@optional
- (void)slotMachineWillStartSliding:(WTLuckMachineView *)slotMachine;
- (void)slotMachineDidEndSliding:(WTLuckMachineView *)slotMachine;

@end

@interface WTLuckRollView : UIView

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSArray *points;

- (void)startSliding;
- (void)stopSliding;

@end
