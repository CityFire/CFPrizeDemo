//
//  CFNavgationViewController.m
//  CFPrizeDemo
//
//  Created by wjc on 16/11/7.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#define IsDeviceVersionIOS7 ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)

#define kUIViewControllerBackViewColor [UIColor colorWithRed:27.0/255.0 green:27.0/255.0 blue:27.0/255.0 alpha:1.0]

#import "CFNavgationViewController.h"

@interface CFNavgationViewController ()

@end

@implementation CFNavgationViewController

+ (void)initialize {
    [self initNavgationBarTheme];
}

+ (void)initNavgationBarTheme {
    UINavigationBar *appearance = [UINavigationBar appearance];
    if (IsDeviceVersionIOS7) {
        [appearance setBackgroundImage:[UIColor cf_imageWithColor:kUIViewControllerBackViewColor] forBarMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:18];
    [appearance setTitleTextAttributes:textAttrs];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
