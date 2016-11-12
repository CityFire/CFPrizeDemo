//
//  PrizeTurnRollViewController.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/12.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "PrizeTurnRollViewController.h"
#import "WTLotteryCell.h"
#import "WTLotteryButton.h"

#define HScreen [[UIScreen mainScreen] bounds].size.height
#define WScreen [[UIScreen mainScreen] bounds].size.width
#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

@interface PrizeTurnRollViewController () {
    UIView *lotteryView;
    UIView *lotteryBgView;
    WTLotteryCell *lotteryCell1;
    WTLotteryCell *lotteryCell2;
    WTLotteryCell *lotteryCell3;
    WTLotteryCell *lotteryCell4;
    WTLotteryCell *lotteryCell5;
    WTLotteryCell *lotteryCell6;
    WTLotteryCell *lotteryCell7;
    WTLotteryCell *lotteryCell8;
    WTLotteryCell *lotteryCell9;
    WTLotteryCell *lotteryCell10;
    
    WTLotteryButton *startButton;
    WTLotteryCell *currentView;
    
    NSArray *array;
    NSTimer *timer;
    
    float intervalTime;//变换时间差（用来表示速度）
    float accelerate;//减速度
    float endTimerTotal;//减速共耗时间
    int a;

}

@end

@implementation PrizeTurnRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initLottery];
    a = 0;
}

// 初始化抽奖视图
- (void)initLottery {
    lotteryBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen)];
    [self.view addSubview:lotteryBgView];
    lotteryBgView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    lotteryBgView.hidden = YES;
    
    UIButton *lotteryBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:lotteryBt];
    lotteryBt.frame = CGRectMake(WScreen-70, 95, 50, 50);
    lotteryBt.layer.masksToBounds = YES;
    lotteryBt.layer.cornerRadius = 25;
    lotteryBt.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.5];
    [lotteryBt setTitle:@"每日\n抽奖" forState:UIControlStateNormal];
    [lotteryBt setTitleColor:[UIColor colorWithRed:1 green:0.81 blue:0.18 alpha:1] forState:UIControlStateNormal];
    lotteryBt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    lotteryBt.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [lotteryBt addTarget:self action:@selector(lotteryBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    lotteryView = [[UIView alloc] initWithFrame:CGRectMake((WScreen-260)/2, 160, 260, 260)];
    [self.view addSubview:lotteryView];
    lotteryView.hidden = YES;
    lotteryView.backgroundColor = [UIColor whiteColor];
    UIButton *hideLotteryBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [lotteryView addSubview:hideLotteryBt];
    hideLotteryBt.frame = CGRectMake(240, 0, 20, 20);
    [hideLotteryBt setImage:[UIImage imageNamed:@"lottery5"] forState:UIControlStateNormal];
    [hideLotteryBt addTarget:self action:@selector(hideLotteryBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lotteryTitle = [[UILabel alloc] initWithFrame:CGRectMake((260-150)/2, 22, 150, 30)];
    lotteryTitle.backgroundColor = [UIColor colorWithRed:0.99 green:0.78 blue:0.19 alpha:1];
    lotteryTitle.text = @"每日抽奖";
    lotteryTitle.textAlignment = NSTextAlignmentCenter;
    
    lotteryTitle.font = [UIFont boldSystemFontOfSize:14];
    lotteryTitle.textColor = [UIColor whiteColor];
    [lotteryView addSubview:lotteryTitle];
    
    endTimerTotal = 5.0;
    float originX = 15;
    float space = 10;
    float cellWidth = 50;
    float cellHeight = 43;
    float orginY = 75;
    
    lotteryCell1 = [self createLotteryCellWithFrame:CGRectMake(originX, orginY, cellWidth, cellHeight) text:@"2"];
    
    lotteryCell2 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth+space, orginY, cellWidth, cellHeight) text:@"4"];
    
    lotteryCell3 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*2+space*2, orginY, cellWidth, cellHeight) text:@"6"];
    
    lotteryCell4 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY, cellWidth, cellHeight) text:@"8"];
    
    lotteryCell5 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY+cellHeight+space, cellWidth, cellHeight) text:@"10"];
    
    lotteryCell6 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY+(cellHeight+space)*2, cellWidth, cellHeight) text:@"12"];
    
    lotteryCell7 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*2+space*2, orginY+(cellHeight+space)*2, cellWidth, cellHeight) text:@"14"];
    
    lotteryCell8 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*1+space*1, orginY+(cellHeight+space)*2, cellWidth, cellHeight) text:@"16"];
    
    lotteryCell9 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*0+space*0, orginY+(cellHeight+space)*2, cellWidth, cellHeight) text:@"18"];
    
    lotteryCell10 = [self createLotteryCellWithFrame:CGRectMake(originX+cellWidth*0+space*0, orginY+cellHeight+space, cellWidth, cellHeight) text:@"20"];
    
    startButton = [[WTLotteryButton alloc] initWithFrame:CGRectMake(originX+cellWidth+space, orginY+cellHeight+space, cellWidth*2+space, cellHeight)];
    [lotteryView addSubview:startButton];
    [startButton addTarget:self action:@selector(prepareLotteryAction) forControlEvents:UIControlEventTouchUpInside];
    
    array = [[NSArray alloc] initWithObjects:lotteryCell1, lotteryCell2, lotteryCell3,lotteryCell4, lotteryCell5, lotteryCell6, lotteryCell7, lotteryCell8, lotteryCell9, lotteryCell10, nil];
    for (int i = 0; i < array.count; i++) {
        WTLotteryCell *view = array[i];
        view.tag = i;
    }
}

// 创建视图
- (WTLotteryCell *)createLotteryCellWithFrame:(CGRect)frame text:(NSString *)text {
    WTLotteryCell *lotteryCell = [[WTLotteryCell alloc] initWithFrame:frame];
    [lotteryView addSubview:lotteryCell];
    lotteryCell.text = text;
    return lotteryCell;
}

// 显示与隐藏抽奖视图
- (void)lotteryBtAction {
    lotteryBgView.hidden = NO;
    lotteryView.hidden = NO;
}

- (void)hideLotteryBtAction {
    lotteryBgView.hidden = YES;
    lotteryView.hidden = YES;
}

// 抽奖按钮按下后的准备工作
- (void)prepareLotteryAction {
    intervalTime = 0.7; // 起始的变换时间差（速度）
    currentView.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
    currentView.image = [UIImage imageNamed:@"lottery3"];
    
    currentView = [array objectAtIndex:0];
    currentView.textColor = [UIColor whiteColor];
    currentView.image = [UIImage imageNamed:@"lottery2"];
    startButton.enabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLotterry:) userInfo:currentView repeats:NO];
    
#pragma mark- 模拟网络请求的代码
    NSTimer *netRequestTimer=[NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(netAction) userInfo:nil repeats:NO];
    
}

// 抽奖中间获取网络数据后调用该方法停止抽奖
- (void)netAction {
    
    int resultValue = 9;
    [self endLotteryWithResultValue:resultValue];
    
}

// 开始抽奖
- (void)startLotterry:(NSTimer *)sender {
    
    NSInteger count = array.count;
    NSTimer *myTimer = (NSTimer *)sender;
    UIView *preView = (UIView *)myTimer.userInfo;
    NSInteger index;
    if (!preView) {
        index = 0;
    }
    else {
        index = [array indexOfObject:preView];
    }
    if (index == count-1) {
        currentView = [array objectAtIndex:0];
    }
    else {
        currentView = [array objectAtIndex:index+1];
    }
    
    [self moveCurrentView:currentView inArray:array];
    
    
    if (intervalTime > 0.1) {
        intervalTime = intervalTime - 0.1;
    }
    NSLog(@"intervalTime is %f",intervalTime);
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLotterry:) userInfo:currentView repeats:NO];
}

// 单元格移动一下
- (void)moveCurrentView:(WTLotteryCell *)curView inArray:(NSArray *)views {
    
    WTLotteryCell *preView = (WTLotteryCell *)[self previewByCurrentView:curView inArray:views];
    
    preView.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
    preView.image=[UIImage imageNamed:@"lottery3"];
    curView.textColor = [UIColor whiteColor];
    curView.image=[UIImage imageNamed:@"lottery2"];
    
}

- (void)endLotteryWithResultValue:(int)resultValue {
    intervalTime = 0.3;
    
    NSInteger currentIndex = [array indexOfObject:currentView];
    NSInteger count = array.count;
    
    NSInteger endLength;
    
    if (currentIndex+1 >= resultValue) {
        endLength = count-(currentIndex+1-resultValue);
    }
    else {
        endLength = resultValue-(currentIndex+1);
    }
    
    accelerate = (2*endTimerTotal/endLength-2*intervalTime)/(endLength-1);
    
    [self moveToStopWithAccelerate];
}

// 减速至停止
- (void)moveToStopWithAccelerate {
    
    static float timeTotal = 0;
    
    if (a <= accelerate) {
        
        a++;
        intervalTime = 0.3 * a;
        NSLog(@"totalTime is %f", intervalTime);
        
        [timer invalidate];
        currentView = (WTLotteryCell *)[self nextViewByCurrentView:currentView inArray:array];
        [self moveCurrentView:currentView inArray:array];
        timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(moveToStopWithAccelerate) userInfo:nil repeats:NO];
    }
    if (a >= accelerate) {
        
        [timer invalidate];
        timeTotal = 0;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"恭喜你！抽中%ld个积分",(currentView.tag+1)*2] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

        startButton.enabled = YES;
        intervalTime = 0.7;
        a = 0;
    }
    
}

// 得到上一个view
- (UIView *)previewByCurrentView:(UIView *)curView inArray:(NSArray *)views {
    NSInteger count = views.count;
    NSInteger curIndex = [views indexOfObject:curView];
    NSInteger preIndex;
    if (curIndex==0) {
        preIndex = count-1;
    }
    else {
        preIndex = curIndex-1;
    }
    return [views objectAtIndex:preIndex];
}

// 得到下一个view
- (UIView *)nextViewByCurrentView:(UIView *)curView inArray:(NSArray *)views {
    NSInteger count = views.count;
    NSInteger curIndex = [views indexOfObject:curView];
    NSInteger nextIndex;
    if (curIndex == count-1) {
        nextIndex = 0;
    }
    else {
        nextIndex = curIndex+1;
    }
    return [views objectAtIndex:nextIndex];
}

// 计算时间的加速度
- (float)accelerateWithResultValue:(int)resultValue {
//    float a;
    NSInteger currentIndex = [array indexOfObject:currentView];
    NSInteger count = array.count;
    
    NSInteger endLength;
    
    if (currentIndex+1>=resultValue) {
        endLength = count-(currentIndex+1-resultValue);
    }
    else {
        endLength = resultValue-(currentIndex+1);
    }
//    a = (2*endTimerTotal/endLength-2*intervalTime)/(endLength-1);
    return endLength;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
