//
//  LevelView.m
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LevelView.h"

@interface LevelView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation LevelView

- (void)setPercent:(CGFloat)percent{
    _percent = percent;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createAnimation];
    });
}

- (void)createAnimation{

    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.removedOnCompletion = NO;
    animation.values = @[@(-self.percent * self.yxy_w), @0];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.75;

    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.yxy_w * self.percent, self.yxy_h)];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.strokeColor = ColorWithHex(@"ffc41f").CGColor;
    self.shapeLayer.lineWidth = self.yxy_h;

    [self.shapeLayer addAnimation:animation forKey:nil];
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.backgroundColor = ColorWithHex(@"ffc41f").CGColor;
        self.shapeLayer.strokeColor = ColorWithHex(@"ffc41f").CGColor;
        [self.layer addSublayer:self.shapeLayer];
    }
    return _shapeLayer;
}

@end
