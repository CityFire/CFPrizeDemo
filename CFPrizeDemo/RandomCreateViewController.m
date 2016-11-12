//
//  RandomCreateViewController.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/11.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import "RandomCreateViewController.h"
#import "UIViewController+CFToast.h"

@interface RandomCreateViewController ()

@end

@implementation RandomCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[self button]];
    // 创建View
    [self randomCreateRandomSortedView];
}

- (void)randomCreateRandomSortedView {
    [self showHud:@"正在加载"];
//    [self showLoading:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_queue_t serialQueue = dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);
        NSArray *arr = @[@"1", @"2", @"3"];
        // 获取随机排序的数组
        arr = [self getRandomSortedArray:arr];
        for (NSInteger i = 0; i < arr.count; i++) {
            dispatch_async(serialQueue, ^{
                sleep(1.0);
                dispatch_async(dispatch_get_main_queue(), ^{
                    int index = [arr[i] intValue];
                    NSLog(@"index:%@", @(index));
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-100) * 0.5, 150 + 100 * index, 100, 40)];
                    float r = arc4random_uniform((uint32_t)255);
                    float g = arc4random_uniform((uint32_t)255);
                    float b = arc4random_uniform((uint32_t)255);
                    UIColor *color = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
                    view.backgroundColor = color;
                    view.tag = 100 + i;
                    [self.view addSubview:view];
                    [self.view sendSubviewToBack:view];
                });
            });
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHudWithComplete:@"加载完成"];
//        [self showLoading:NO];
    });
}

- (NSArray *)getRandomSortedArray:(NSArray *)arr {
    NSArray *array = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return array;
}

- (void)randomCreateView {
//    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 3; i++) {
            UIView *view = [self.view viewWithTag:100 + i];
            [view removeFromSuperview];
        }
    });
    // 创建View
    [self randomCreateRandomSortedView];

}

- (UIButton *)button {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(randomCreateView) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(130, 97, 101, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitle:@"随机创建View" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return btn;
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
