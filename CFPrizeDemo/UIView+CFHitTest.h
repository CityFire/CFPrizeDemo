//
//  UIView+CFHitTest.h
//  CFPrizeDemo
//
//  Created by wjc on 16/11/13.
//  Copyright © 2016年 CityFire. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @abstract CFHitTestViewBlock
 *
 * @param 其余参数 参考UIView hitTest:withEvent:
 * @param returnSuper 是否返回Super的值。如果*returnSuper=YES,则代表会返回 super hitTest:withEvent:, 否则则按照block的返回值(即使是nil)
 *
 * @discussion 切记，千万不要在这个block中调用self hitTest:withPoint,否则则会造成递归调用。这个方法就是hitTest:withEvent的一个代替。
 */
typedef UIView * (^CFHitTestViewBlock)(CGPoint point, UIEvent *event, BOOL *returnSuper);
typedef BOOL (^CFPointInsideBlock)(CGPoint point, UIEvent *event, BOOL *returnSuper);

@interface UIView (CFHitTest)

// althought this is strong ,but i deal it with copy
@property(nonatomic, strong) CFHitTestViewBlock hitTestBlock;
@property(nonatomic, strong) CFPointInsideBlock pointInsideBlock;

@end
