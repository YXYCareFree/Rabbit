//
//  HomeAnimationView.m
//  YouTo
//
//  Created by 杨肖宇 on 2018/12/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeAnimationView.h"
#import "ShadeView.h"
#import "UIButton+WebCache.h"
#import "UserInfoController.h"
#import "AccountManager.h"

@interface HomeAnimationView ()

@property (nonatomic, strong) UIImageView *centerImgV;
@property (nonatomic, strong) ShadeView *firstCircleV;
@property (nonatomic, strong) ShadeView *secondCircleV;
@property (nonatomic, strong) ShadeView *thirdCircleV;
@property (nonatomic, strong) NSMutableArray *imgBtnArr;

@end

@implementation HomeAnimationView

- (instancetype)initWithFrame:(CGRect)frame centerImageUrl:(NSString *)imgUrl roundImageUrlGroup:(NSArray *)urlGroup{
    if (self = [super initWithFrame:frame]) {
        self.centerImgUrl = imgUrl;
        [self setUI];

        self.roundImgGroup = urlGroup;
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.thirdCircleV];
    [self addSubview:self.secondCircleV];
    [self addSubview:self.firstCircleV];
    
    [self addSubview:self.centerImgV];
    [self.centerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@100);
    }];
    
    [self.thirdCircleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@308);
    }];
    [self.secondCircleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@228);
    }];
    [self.firstCircleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@156);
    }];
}

- (void)setCenterImgUrl:(NSString *)centerImgUrl{
    _centerImgUrl = centerImgUrl;
    [self.centerImgV sd_setImageWithURL:URLWithStr(centerImgUrl) placeholderImage:self.centerImgV.image];
}

- (void)setRoundImgGroup:(NSArray *)roundImgGroup{
    _roundImgGroup = roundImgGroup;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[YXYButton class]]) {
            [subView removeFromSuperview];
        }
    }
    
    NSArray *arrX = @[@"58", @"239", @"155", @"85", @"283", @"205", @"73", @"331", @"222", @"36"];
    NSArray *arrY = @[@"90", @"100", @"163", @"206", @"202", @"257", @"307", @"323", @"355", @"388"];
    
    for (NSInteger i = 0; i < roundImgGroup.count; i++) {
        if (i >= 10) return;
        
        MatchUserModel *model = roundImgGroup[i];
        YXYButton *btn = [[YXYButton alloc] init];
        [btn setCornerRadius:25];
        [btn sd_setImageWithURL:URLWithStr(model.headImg) forState:UIControlStateNormal placeholderImage:LoadImageWithName(@"default_home")];
        [self addSubview:btn];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.tag = Tag_Match + i;
        [btn addTarget:self action:@selector(iconClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgBtnArr addObject:btn];
        [self insertSubview:btn belowSubview:self.centerImgV];
        btn.layer.borderColor = WhiteColor.CGColor;
        btn.layer.borderWidth = 1;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@([arrX[i] floatValue]));
            make.top.equalTo(@([arrY[i] floatValue] - 64));
            make.width.height.equalTo(@50);
        }];
    }
}

- (void)iconClicked:(YXYButton *)btn{
    MatchUserModel *model = self.roundImgGroup[btn.tag - Tag_Match];
    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
    PushVC(vc);
}

- (void)startScan{
    [self.firstCircleV startAnimation];
    [self.secondCircleV startAnimation];
    [self.thirdCircleV startAnimation];
}

- (void)stopScan{
    [self.firstCircleV stopAnimation];
    [self.secondCircleV stopAnimation];
    [self.thirdCircleV stopAnimation];
}

- (void)startAnimation{
    for (NSInteger i = 0; i < self.imgBtnArr.count; i++) {
        YXYButton *btn = self.imgBtnArr[i];
        [UIView animateWithDuration:1 animations:^{
            btn.center = self.centerImgV.center;
        } completion:^(BOOL finished) {
            if ( i == self.imgBtnArr.count - 1) {
                MatchUserModel *model = self.roundImgGroup[0];
                [self.centerImgV sd_setImageWithURL:URLWithStr(model.headImg)];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:model.memberId];
                    PushVC(vc);
                });
            }
        }];
    }
}

- (void)centerImgClicked{
    UserInfoController *vc = [[UserInfoController alloc] initWithMemberId:[AccountManager memberId]];
    PushVC(vc);
}


- (UIImageView *)centerImgV{
    if (!_centerImgV) {
        _centerImgV = [[UIImageView alloc] init];
        [_centerImgV setCornerRadius:50];
        [_centerImgV sd_setImageWithURL:URLWithStr(self.centerImgUrl) placeholderImage:LoadImageWithName(@"default_home")];
        _centerImgV.layer.borderWidth = 4;
        _centerImgV.layer.borderColor = Color_Main.CGColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerImgClicked)];
        [_centerImgV addGestureRecognizer:tap];
        _centerImgV.userInteractionEnabled = YES;
    }
    return _centerImgV;
}

- (ShadeView *)firstCircleV{
    if (!_firstCircleV) {
        _firstCircleV = [[ShadeView alloc] init];
        [_firstCircleV setCornerRadius:78];
        _firstCircleV.backgroundColor = [UIColor colorWithRed:84/255.0 green:218/255.0 blue:218/255.0 alpha:0.42];
    }
    return _firstCircleV;
}

- (ShadeView *)secondCircleV{
    if (!_secondCircleV) {
        _secondCircleV = [[ShadeView alloc] init];
        [_secondCircleV setCornerRadius:114];
        _secondCircleV.backgroundColor = [UIColor colorWithRed:84/255.0 green:218/255.0 blue:218/255.0 alpha:0.28];
    }
    return _secondCircleV;
}

- (ShadeView *)thirdCircleV{
    if (!_thirdCircleV) {
        _thirdCircleV = [[ShadeView alloc] init];
        [_thirdCircleV setCornerRadius:154];
        _thirdCircleV.backgroundColor = [UIColor colorWithRed:84/255.0 green:218/255.0 blue:218/255.0 alpha:0.14];
    }
    return _thirdCircleV;
}

- (NSMutableArray *)imgBtnArr{
    if (!_imgBtnArr) {
        _imgBtnArr = [[NSMutableArray alloc] init];
    }
    return _imgBtnArr;
}


//    //    设半径为R。
//    //    x=r∗cos(θ)
//    //    y=r∗sin(θ)
//    //    其中 0⩽r⩽R，t为0-1均匀分布产生的随机数，r=sqrt(t)∗R，θ=2π∗t,t∼U(0,1)
//    CGFloat R = kScreenWidth / 2 - 20;
//    NSMutableArray *arrX = [[NSMutableArray alloc] init];
//    NSMutableArray *arrY = [[NSMutableArray alloc] init];
//
//    for (NSInteger i = 0; i < self.roundImgGroup.count; i++) {
//
//        CGFloat x = 0;
//        CGFloat y = 0;
//        CGFloat r = 0;
//        __block BOOL validate = YES;
//        do {
//            double value=(double)arc4random()/0x100000000;
//            r = sqrt(value) * R;
//            x = r * cos(2 * value * M_PI);
//            y = r * sin(2 * value * M_PI);
//            [arrX enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                CGFloat tx = [obj floatValue];
//                if (fabs(tx - x) < 30) {
//
//                    NSNumber *tempY = arrY[idx];
//                    if (fabs([tempY floatValue] - y) < 30) {
//                        validate = NO;
//                    }
//                }
//            }];
//
//        } while (fabs(x) < 40 || fabs(y) < 40 || !validate);
//
//        [arrX addObject:@(x)];
//        [arrY addObject:@(y)];
//
//        YXYButton *btn = [[YXYButton alloc] init];
//        [btn sd_setImageWithURL:URLWithStr(self.centerImgUrl) forState:UIControlStateNormal];
////        CGFloat scale = fabs(self.yxy_cx - fabs(x)) / R;
////        CGFloat width = 35 / scale;
//        CGFloat scale = r / R;
//
//        CGFloat width = 35 / scale;
//
//        NSLog(@"\nx==%f, cx=%f, scale=%f, width=%f\n", x, self.yxy_cx, scale, width);
//
//        [self addSubview:btn];
//        [self.imgBtnArr addObject:btn];
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self).offset(x);
//            make.centerY.equalTo(self).offset(y);
//            make.height.width.equalTo(@(width));
//            [btn setCornerRadius:(width / 2)];
//        }];
//    }

@end
