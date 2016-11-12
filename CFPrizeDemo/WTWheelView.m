//
//  WTWheelView.m
//  tutuapp
//
//  Created by wjc on 14/11/12.
//  Copyright © 2014年 WeiPhone. All rights reserved.
//

#import "WTWheelView.h"
#import "WTButton.h"
#import "UIView+CFFirstResponder.h"

@interface WTWheelView () <CAAnimationDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *centerView;
@property (nonatomic, strong, getter=isSelectedBtn) UIButton *selectedBtn;
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation WTWheelView

- (IBAction)chooseNumber:(id)sender {
    if (!self.isSelectedBtn) {
        return;
    }
    [self stopAnimation];
    if (![self.centerView.layer animationForKey:@"anim"]) {
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = @"transform.rotation";
        anim.toValue = @(2 * M_PI * 15 - M_PI * 2 / 12 * self.selectedBtn.tag);
        anim.duration = 5;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
//        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        anim.delegate = self;
        [self.centerView.layer addAnimation:anim forKey:@"anim"];
        self.userInteractionEnabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.centerView.transform = CGAffineTransformMakeRotation([anim.toValue floatValue]);
            self.link.paused = YES;
            [self.centerView.layer removeAnimationForKey:@"anim"];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"恭喜你!" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            __weak __typeof(self)weakSelf = self;
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                weakSelf.link.paused = NO;
                self.userInteractionEnabled = YES;
            }];
//            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [self.cf_viewController presentViewController:alertController animated:YES completion:nil];
        });
    }
}

/*
#pragma mark - Animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    // 选中的图片居中
    self.centerView.transform = CGAffineTransformMakeRotation(-(self.selectedBtn.tag * M_PI / 6));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}
 */

#pragma mark - 之前的版本是手写代码，现在改为加载Xib文件
+ (instancetype)wheelView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WTWheelView" owner:nil options:nil] lastObject];
}

// 裁剪图片
- (UIImage *)clipImage:(UIImage *)image withIndex:(int)index {
    CGFloat imageW = image.size.width / 12 * [UIScreen mainScreen].scale;
    CGFloat imageH = image.size.height * [UIScreen mainScreen].scale;
    CGFloat imageX = index * imageW;
    CGFloat imageY = 0;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(imageX, imageY, imageW, imageH));
    return [UIImage imageWithCGImage:imageRef scale:2.2 orientation:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.centerView.userInteractionEnabled = YES;
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *imageSelected = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    // 从大图片中裁剪对应星座的图片
    CGFloat smallW = image.size.width / 12 * [UIScreen mainScreen].scale;
    CGFloat smallH = image.size.height * [UIScreen mainScreen].scale;
    // 添加按钮
    for (int i = 0; i < 12; i++) {
        WTButton *btn = [WTButton buttonWithType:UIButtonTypeCustom];
        CGRect smallRect = CGRectMake(i * smallW, 0, smallW, smallH);
        // 裁剪图片
        // CGImageCreateWithImageInRect只认像素
        CGImageRef smallImage = CGImageCreateWithImageInRect(image.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        // 选中状态的图片
        CGImageRef smallSelected = CGImageCreateWithImageInRect(imageSelected.CGImage, smallRect);
        [btn setImage:[UIImage imageWithCGImage:smallSelected] forState:UIControlStateSelected];
        // 背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, 68, 143);
        // 设置定位点和位置
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.center = CGPointMake(self.centerView.frame.size.width * 0.5, self.centerView.frame.size.height * 0.5);
        CGFloat angle = M_PI * 2 / 12 * i;
        // 设置旋转角度（绕着锚点进行旋转）
//        CGFloat angle = (30 * i) / 180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(angle);
        btn.tag = i;
//        btn.imageEdgeInsets = UIEdgeInsetsMake(-50, 0, 0, 0);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:btn];
//        if (i == 0) {
//            [self btnClick:btn];
//        }
    }
}

#pragma mark - 按钮响应事件：修改按钮选中状态

- (void)btnClick:(WTButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected  = YES;
    self.selectedBtn = btn;
}

// 核心动画不能改变图层的属性
- (void)startAnimation {
    if (self.link) {
        return;
    }
    // 1秒刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopAnimation {
    [self.link invalidate];
    self.link = nil;
}

- (void)update {
    self.centerView.transform = CGAffineTransformRotate(self.centerView.transform, M_PI * 2 / 60 / 10);
}

@end
