//
//  ShadeView.m
//  YouTo
//
//  Created by 杨肖宇 on 2018/12/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShadeView.h"

@interface ShadeView ()

@property (nonatomic, assign) BOOL isLoop;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation ShadeView

- (void)startAnimation{
    self.isLoop = YES;
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            if (self.isLoop) {
                [self startAnimation];
            }
        }];
    }];

    
//    [CATransaction begin];
//    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    fadeAnimation.fromValue = 0;
//    fadeAnimation.toValue = @(1);
//    fadeAnimation.repeatCount = HUGE_VALF;
//    fadeAnimation.duration = 1.5;
//
//
////    [self.emitterLayer addAnimation:fadeAnimation forKey:nil];
////    [self.shapeLayer addAnimation:fadeAnimation forKey:nil];
//    [self.layer addAnimation:fadeAnimation forKey:nil];
//
//    [CATransaction commit];
}

- (void)stopAnimation{
    self.isLoop = NO;
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.bounds = self.bounds;
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

- (CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.bounds = self.bounds;
        [self.layer addSublayer:_emitterLayer];
    }
    return _emitterLayer;
}

//+ (Class)layerClass{
//    return [CAShapeLayer class];
//}
@end
