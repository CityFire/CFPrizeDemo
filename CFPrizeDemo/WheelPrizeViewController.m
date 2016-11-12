//
//  WheelPrizeViewController.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/7.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "WheelPrizeViewController.h"
#import "WTWheelView.h"

@interface WheelPrizeViewController ()

@property (nonatomic, strong) WTWheelView *wheelView;

@end

@implementation WheelPrizeViewController

- (WTWheelView *)wheelView {
    if (!_wheelView) {
        _wheelView = [WTWheelView wheelView];
        _wheelView.center = self.view.center;
        [self.view addSubview:_wheelView];
    }
    return _wheelView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"大转盘";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LuckyBackground"].CGImage);
    [self.wheelView startAnimation];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.wheelView.center = self.view.center;
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
