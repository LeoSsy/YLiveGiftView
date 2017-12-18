//
//  YGiftLabel.m
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YGiftLabel.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation YGiftLabel

/**
 绘制填充颜色

 @param rect rect
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    self.textColor = [UIColor orangeColor];
    [super drawRect:rect];

    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor whiteColor];
    [super drawRect:rect];

}

- (void)startAnimation:(completion)completion{

    [UIView animateKeyframesWithDuration:0.25 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:1 animations:^{
            self.transform = CGAffineTransformMakeScale(0.7, 0.7);
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completion) {
                completion(YES);
            }
        }];
    }];
}


@end
