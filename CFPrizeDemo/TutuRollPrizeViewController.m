//
//  Phone_TutuRollPrizeViewController.m
//  tutuapp
//
//  Created by weiphone-ued on 14-10-16.
//  Copyright (c) 2014年 WeiPhone. All rights reserved.
//

#import "TutuRollPrizeViewController.h"
#import "UIViewController+CFToast.h"
#import "WTThemeManager.h"
#import "WTAward.h"
#import "WTLuckMachineView.h"

@interface TutuRollPrizeViewController ()<WTLuckMachineViewDelegate>

@property (nonatomic, strong) NSArray *datasArray;
@property (nonatomic, strong) NSArray *awardArray;

@property (nonatomic, weak) UIScrollView *backScrollView;
@property (nonatomic, strong) UIImage *navigationBarBgImage;
@property (nonatomic, weak) WTLuckMachineView *rollView;

@end

@implementation TutuRollPrizeViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slotmachine_background.png"]];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 125, 25)];
    imageView1.image = [UIImage imageNamed:@"slotmachine_title.png"];
    [self.navigationItem setTitleView:imageView1];
    
    
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectZero];
    scrollview.alwaysBounceVertical = YES;
    scrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollview];
    self.backScrollView = scrollview;
    
    
    WTLuckMachineView *prizeView = [[WTLuckMachineView alloc] initWithFrame:CGRectZero];
    prizeView.delegate = self;
    self.rollView = prizeView;
    // eg.
//    [self.rollView setPoints:@[@1,@2,@3]];
//    [self.rollView stopSliding];
    
    [self.backScrollView addSubview:prizeView];
//    [self.backScrollView addSubview:tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 加载奖品数据
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 6; i++) {
        WTAward *award = [WTAward new];
        award.Aid = [NSString stringWithFormat:@"prize%@", @(i)];
        award.awardCount = [NSString stringWithFormat:@"%@", @(i+1)];
        award.awardImage = [UIImage imageNamed:@"rollCoin"];
        award.prizeDesc = @"中奖了";
        award.awardName = @"iPhone 7 Plus";
        [arr addObject:award];
    }
    self.awardArray = [NSArray arrayWithArray:[arr copy]];
    
    // 获取拥有和消耗数量
    [self beginToGetCarrotData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    [self showHud:@"加载数据中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rollView setDatas:self.awardArray];
        [self hideHud];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect frame = self.view.bounds;
    
    self.backScrollView.frame = frame;
    self.backScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height+20);
    
    self.rollView.frame = CGRectMake(0.0, 0.0, frame.size.width, 195);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 加载数据

// 获取萝卜数量及下次抽奖消耗萝卜数量
- (void)beginToGetCarrotData
{
    // 这些都是从服务器上获取，现在假死的数据
    NSInteger ownCarrot = 120;
    NSInteger consumerCarror = 40;
    [self.rollView setOwnCarrot:ownCarrot];
    [self.rollView setConsumerCarror:consumerCarror];
    // 获取摇奖次数
    NSInteger count = (NSInteger)ownCarrot / consumerCarror;
    [self.rollView setRollCount:count];
}

// 摇动结束后返回摇到的结果
- (void)getLotteryResultData
{
    // 成功 服务器中获取结果
    if (true) {
        [self.rollView setPoints:@[@1,@1,@1]];
        [self showHud:@"中奖了"];
        [self hideHud];
    }
    else {
        int _slotOneIndex = 20;
        int _slotTwoIndex = 30;
        int _slotThreeIndex = 10;
        printf("====%d %d %d\n",_slotOneIndex,_slotTwoIndex,_slotThreeIndex);
        [self.rollView setPoints:[NSArray arrayWithObjects:@(_slotOneIndex), @(_slotTwoIndex), @(_slotThreeIndex), nil]];
        [self.rollView stopSliding];
    }
}

#pragma mark -WTLuckMachineViewDelegate

- (void)slotMachineWillStartSliding:(WTLuckMachineView *)slotMachine
{
    // 摇动结束后返回摇到的结果
    [self getLotteryResultData];
}

- (void)slotMachineDidEndSliding:(WTLuckMachineView *)slotMachine
{
    // 获取拥有和消耗数量
    [self beginToGetCarrotData];
}

// 兑换商品成功
- (void)exchangeSuccess
{
    
}

@end
