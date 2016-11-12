//
//  WTLuckMachineView.m
//  tutuapp
//
//  Created by wjc on 14-11-12.
//  Copyright (c) 2014年 WeiPhone. All rights reserved.
//

#import "WTLuckMachineView.h"
#import "WTThemeManager.h"
#import "WTAward.h"
#import "UIViewController+CFToast.h"
#import "UIView+CFFirstResponder.h"

@interface WTLuckMachineView ()

@property (nonatomic, weak) UIImageView *backGroundImageView;
@property (nonatomic, weak) UIImageView *ownImage;
@property (nonatomic, weak) UIImageView *consumerImage;
@property (nonatomic, weak) UIView *ownView;
@property (nonatomic, weak) UIView *consumerView;
@property (nonatomic, weak) UIImageView *carrotImage;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *ownLabel;
@property (nonatomic, weak) UILabel *consumerLabel;
@property (nonatomic, weak) UIButton *ownBtn;
@property (nonatomic, weak) UIButton *consumerBtn;
@property (nonatomic, weak) WTLuckRollView *luckRollView;
@property (nonatomic, weak) UIButton *doneBtn;
@property (nonatomic, weak) UIImageView *doneImageView;
@property (nonatomic, weak) UIButton *coinBtn;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UIImageView *norLineImageView;

@end

@implementation WTLuckMachineView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIImage *image = [UIImage imageNamed:@"rollPrize_back.png"];
    UIImageView *backgroundimage = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:100 topCapHeight:100]];
    [self addSubview:backgroundimage];
    self.backGroundImageView = backgroundimage;
    
    WTLuckRollView *leftview = [[WTLuckRollView alloc] initWithFrame:CGRectZero];
    [self addSubview:leftview];
    self.luckRollView = leftview;
    
    _ownCarrot = 0;
    _consumerCarror = 0;
    
    for(int i = 0; i < 2; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"number_background.png"]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[WTThemeManager getFont:15.0]];
        [button setImage:[UIImage imageNamed:@"carrot_slotmachine.png"] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, -4);
        
        if(i == 0) {
            self.ownImage = imageView;
            imageView.image = [UIImage imageNamed:@"own_slot.png"];
            self.ownBtn = button;
        }
        else {
            self.consumerImage = imageView;
            imageView.image = [UIImage imageNamed:@"consumer_slot.png"];
            self.consumerBtn = button;
        }
        [self addSubview:button];
        
        [self addSubview:imageView];
    }
    
    // 动画效果 gif ImageIO
    UIImageView *link = [[UIImageView alloc]initWithFrame:CGRectZero];
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:7];
    for (NSInteger i = 1; i < 8; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"rollBtn%ld.png",i]]];
    }
    link.image = [UIImage imageNamed:@"rollBtn1.png"];
    link.animationImages = array;
    link.animationDuration = 1;
    link.animationRepeatCount = 1;
    [self addSubview:link];
    self.doneImageView = link;
    
    UIButton *rollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rollBtn addTarget:self action:@selector(startRoll:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rollBtn];
    self.doneBtn = rollBtn;
    
    UIButton *coid = [UIButton buttonWithType:UIButtonTypeCustom];
    [coid setBackgroundImage:[UIImage imageNamed:@"rollPrize_count.png"] forState:UIControlStateNormal];
    [coid setTitle:@"05" forState:UIControlStateNormal];
    coid.titleLabel.font = [WTThemeManager getFont:20];;
    [self addSubview:coid];
    self.coinBtn = coid;
}

#pragma mark -
#pragma mark - 获取摇奖次数

- (void)setRollCount:(NSInteger)rollCount
{
    _rollCount = rollCount;
    [self.coinBtn setTitle:[NSString stringWithFormat:@"%.2ld", _rollCount] forState:UIControlStateNormal];
}

- (void)setOwnCarrot:(NSInteger)ownCarrot
{
    [self.ownBtn setTitle:[NSString stringWithFormat:@"%ld", ownCarrot] forState:UIControlStateNormal];
}

- (void)setConsumerCarror:(NSInteger)consumerCarror
{
    [self.consumerBtn setTitle:[NSString stringWithFormat:@"-%ld", consumerCarror] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    CGFloat leftMargin = 5.0;
    self.backGroundImageView.frame = CGRectMake(leftMargin, leftMargin, frame.size.width-leftMargin*2, frame.size.height);
    
    self.ownImage.frame = CGRectMake(leftMargin*3, leftMargin+12, 33, 16);
    self.consumerImage.frame = CGRectMake(self.ownImage.right+100, self.ownImage.top, self.ownImage.width, self.ownImage.height);
    self.ownBtn.frame = CGRectMake(self.ownImage.right+3, 13, 66, 23);
    self.consumerBtn.frame = CGRectMake(self.consumerImage.right+3, self.ownBtn.top, self.ownBtn.width, self.ownBtn.height);
    
    // 等比放大
    CGFloat luckWidth = 246.0;
    CGFloat luckHeight =  141.0;
//    CGFloat bili = (frame.size.height-leftMargin*4) / luckHeight;
//    luckWidth = bili * luckWidth;
//    luckHeight = bili * luckHeight;
    
    self.luckRollView.frame = CGRectMake(leftMargin*2, self.consumerBtn.bottom+12, luckWidth, luckHeight);
    self.doneImageView.frame = CGRectMake(leftMargin*2+luckWidth+(frame.size.width-luckWidth-leftMargin*4-55.0)*0.5, self.consumerBtn.bottom+10.0, 55.0, 120.0);
    self.doneBtn.frame = self.doneImageView.frame;
    self.coinBtn.frame = CGRectMake(leftMargin*2+luckWidth+(frame.size.width-luckWidth-leftMargin*4-39.0)*0.5, self.doneImageView.bottom-15, 39.0, 36.0);
}

- (void)startRoll:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(slotMachineWillStartSliding:)]){
        [self.delegate slotMachineWillStartSliding:self];
    }
    [self.doneImageView startAnimating];
    [self.luckRollView startSliding];
}

// 传递参数给抽奖view
- (void)setDatas:(NSArray *)datas
{
    self.luckRollView.datas = datas;
}

- (void)startSliding
{
    [self.luckRollView startSliding];
}

- (void)stopSliding
{
    [self.luckRollView stopSliding];
    if(self.delegate && [self.delegate respondsToSelector:@selector(slotMachineDidEndSliding:)]){
        [self.delegate slotMachineDidEndSliding:self];
    }
}

- (void)setPoints:(NSArray *)points
{
    self.luckRollView.points = points;
}

@end



@interface WTLuckRollView ()
{
    NSMutableArray *_slotScrollLayerArray;
    BOOL _isSliding;
}

@property (nonatomic, weak) UIImageView *backgroundImageView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UIImageView *norLineImageView;
@property (nonatomic, weak) UIImageView *slidingLineImageView;

@end

@implementation WTLuckRollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageview.image = [UIImage imageNamed:@"slotMachine_back.png"];
    [self addSubview:imageview];
    self.backgroundImageView = imageview;
    
    UIView *contentview = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:contentview];
    self.contentView = contentview;
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"slotMachine.png"];
    self.coverImageView = imageview;
    
    UIImageView *link = [[UIImageView alloc]initWithFrame:CGRectZero];
    link.animationImages = @[[UIImage imageNamed:@"slotmachine_still1.png"],[UIImage imageNamed:@"slotmachine_still2.png"]];
    link.animationDuration = 1;
    link.animationRepeatCount = 0;
    [self addSubview:link];
    [link startAnimating];
    self.norLineImageView = link;
    
    
    link = [[UIImageView alloc]initWithFrame:CGRectZero];
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:11];
    for (NSInteger i = 1; i < 11; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"slotmachine%ld.png",i]]];
    }
    link.animationImages = array;
    link.animationDuration = 1;
    link.animationRepeatCount = 0;
    [self addSubview:link];
    link.hidden = YES;
    self.slidingLineImageView = link;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.backgroundImageView.frame = frame;
    self.contentView.frame = frame;
    self.coverImageView.frame = frame;
    self.norLineImageView.frame = frame;
    self.slidingLineImageView.frame = frame;
    
}

- (void)setDatas:(NSArray *)datas
{
    if (!datas) {
        return;
    }
    _datas = datas;
    [self reloadData];
}

- (void)reloadData
{
    // remove all
    for (CALayer *containerLayer in _contentView.layer.sublayers) {
        [containerLayer removeFromSuperlayer];
    }
    [_slotScrollLayerArray removeAllObjects];
    
    // init
    _slotScrollLayerArray = [NSMutableArray array];
    _points = @[@0,@0,@0];
    
    NSUInteger numberOfSlots = 3;
    CGFloat slotSpacing = 0;
    CGFloat leftMargin = 20.0;
    CGFloat slotWidth = fabs((_contentView.frame.size.width-leftMargin*2) / (CGFloat)numberOfSlots);
    CGFloat slotHeight =fabs(_contentView.frame.size.height-leftMargin*2);
    
    CGFloat oneSlotWidth = 40.0;
    CGFloat oneSlotHeight = 40.0;
    
    for (int i = 0; i < numberOfSlots; i++) {
        CALayer *slotContainerLayer = [[CALayer alloc] init];
        slotContainerLayer.frame = CGRectMake(leftMargin+i * (slotWidth + slotSpacing), leftMargin, slotWidth, slotHeight);
        slotContainerLayer.masksToBounds = YES;
        
        CALayer *slotScrollLayer = [[CALayer alloc] init];
        slotScrollLayer.frame = CGRectMake((slotWidth-oneSlotWidth)*0.5, (slotHeight-oneSlotHeight)*0.5, oneSlotWidth, oneSlotHeight);
        [slotContainerLayer addSublayer:slotScrollLayer];
        
        [_contentView.layer addSublayer:slotContainerLayer];
        [_slotScrollLayerArray addObject:slotScrollLayer];
    }
    
    NSUInteger iconCount = [self.datas count];
    
    //加5次 上3 下2
    NSInteger turnCount = 5;
    CGFloat centerCount = iconCount*3;
    for (int i = 0; i < numberOfSlots; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        
        for (NSInteger j = 0, k = iconCount*turnCount; j < k; j++) {
            WTAward *data = [self.datas objectAtIndex:j%iconCount];
            UIImage *iconImage = data.awardImage;
            
            CALayer *iconImageLayer = [[CALayer alloc] init];
            NSInteger leftMargin = 0;
            NSInteger upMargin = 10;
            iconImageLayer.frame = CGRectMake(leftMargin, (j-centerCount+1) * (oneSlotHeight+upMargin), oneSlotWidth-leftMargin*2, oneSlotHeight);
            iconImageLayer.contents = (id)iconImage.CGImage;
//            iconImageLayer.contentsScale = iconImage.scale;
//            iconImageLayer.contentsGravity = kCAGravityCenter;
            
            [slotScrollLayer addSublayer:iconImageLayer];
        }
        
    }
}


- (void)startSliding
{
    if (_isSliding) {
        return;
    }
    _isSliding = YES;
    [self.norLineImageView stopAnimating];
    self.norLineImageView.hidden = YES;
    [self.slidingLineImageView startAnimating];
    self.slidingLineImageView.hidden = NO;
    
    
    NSUInteger dataCount = [self.datas count];
    NSInteger upMargin = 10;
    
    for (NSInteger i=0, j=[_slotScrollLayerArray count]; i < j; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        
        NSInteger point = [[_points objectAtIndex:i]integerValue];
        
        // 开始
        CABasicAnimation *slideAnimation1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
        slideAnimation1.duration = 2;
        slideAnimation1.toValue = [NSNumber numberWithFloat:(slotScrollLayer.frame.size.height+upMargin) * (point+dataCount)];
        
        // 很快
        CABasicAnimation *slideAnimation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
        slideAnimation2.duration = 0.5;
        slideAnimation2.repeatCount = 150;
        slideAnimation2.beginTime = 2 + 0.25*i;
        slideAnimation2.fromValue = [NSNumber numberWithFloat:slotScrollLayer.position.y];
        slideAnimation2.toValue = [NSNumber numberWithFloat:slotScrollLayer.position.y + (slotScrollLayer.frame.size.height+upMargin)*dataCount];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 50;
        group.removedOnCompletion = NO;
        group.animations = @[slideAnimation1,slideAnimation2];
        [slotScrollLayer addAnimation:group forKey:@"slideAnimation"];
    }
    
    // test
    [self performSelector:@selector(stopSliding) withObject:nil afterDelay:14.0];
}

- (void)stopSliding
{
    NSUInteger dataCount = [self.datas count];
    NSInteger upMargin = 10;
    
    // only test
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (NSInteger i=0, j=[_slotScrollLayerArray count]; i < j; i++) {
//        NSInteger result = arc4random() % dataCount;
//        [array addObject:[NSNumber numberWithInteger:result]];
//    }
//    NSLog(@"%@ ---- > result",array);
//    _points = array;
    
    for (NSInteger i=0, j=[_slotScrollLayerArray count]; i < j; i++) {
        CALayer *slotScrollLayer = [_slotScrollLayerArray objectAtIndex:i];
        [slotScrollLayer removeAnimationForKey:@"slideAnimation"];
        
        NSInteger point = [[_points objectAtIndex:i]integerValue];
        
        CABasicAnimation *slideAnimation2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
        slideAnimation2.fillMode = kCAFillModeForwards;
        slideAnimation2.duration = 0.5;
        slideAnimation2.repeatCount = 5+i*2;
        slideAnimation2.fromValue = [NSNumber numberWithFloat:slotScrollLayer.position.y];
        slideAnimation2.toValue = [NSNumber numberWithFloat:slotScrollLayer.position.y + (slotScrollLayer.frame.size.height+upMargin)*dataCount];
        slideAnimation2.removedOnCompletion = NO;
        
        // 停止
        CABasicAnimation *slideAnimation3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
        slideAnimation3.fillMode = kCAFillModeForwards;
        slideAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        slideAnimation3.duration = 1.0;
        slideAnimation3.beginTime = 1*i+2.5;
        slideAnimation3.fromValue = [NSNumber numberWithFloat:0];
        slideAnimation3.toValue = [NSNumber numberWithFloat:slotScrollLayer.position.y + (slotScrollLayer.frame.size.height+upMargin)*point];
        slideAnimation3.removedOnCompletion = NO;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.duration = 6;
        group.delegate = self;
        group.removedOnCompletion = NO;
        group.animations = @[slideAnimation2, slideAnimation3];
        [slotScrollLayer addAnimation:group forKey:@"slideAnimation1"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        _isSliding = NO;
        
        [self.norLineImageView startAnimating];
        self.norLineImageView.hidden = NO;
        [self.slidingLineImageView stopAnimating];
        self.slidingLineImageView.hidden = YES;
        
        // 通知动画完成，提示中奖情况
        // 假设中奖 只是demo，一般不建议这样写 建议用KVO或通知 代理吧
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.cf_viewController showHud:@"恭喜，中奖了" afterDelay: 1.5];
        });

    }
}

@end
