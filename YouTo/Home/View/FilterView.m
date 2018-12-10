//
//  FilterView.m
//  YouTo
//
//  Created by 杨肖宇 on 2018/12/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FilterView.h"
#import "SDRangeSliderView.h"


@interface FilterView ()

@property (nonatomic, strong) YXYButton *btnSelected;
@property (nonatomic, strong) YXYButton *btnConfirm;
@property (nonatomic, assign) double minValue;
@property (nonatomic, assign) double maxValue;

@end

@implementation FilterView

+ (void)showFilterView:(void (^)(double, double, NSString *))completion{
    FilterView *view = [[FilterView alloc] init];
    view.FilterBlock = completion;
    view.minValue = 12;
    view.maxValue = 50;
    [KEY_WINDOW addSubview:view];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)extracted:(YXYLabel *)maxValue minValue:(YXYLabel *)minValue slider:(SDRangeSliderView *)slider {
    [slider eventValueDidChanged:^(double left, double right) {
        minValue.text = [NSString stringWithFormat:@"%.0f岁", left];
        maxValue.text = [NSString stringWithFormat:@"%.0f岁", right];
    }];
}

- (void)setUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    YXYButton *btn = [[YXYButton alloc] init];
    self.btnConfirm = btn;
    [btn.titleFont(Font_PingFang_Medium(18)).title(@"确定", UIControlStateNormal).color(Color_Main, UIControlStateNormal) addTarget:self action:@selector(confirmClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    btn.backgroundColor = WhiteColor;
    [btn setCornerRadius:5];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(159 + 15 + 44 + 20 + HOME_INDICATOR_HEIGHT));
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@44);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.25 animations:^{
            [self setNeedsLayout];
            [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@(-20 - HOME_INDICATOR_HEIGHT));
                make.left.equalTo(@15);
                make.right.equalTo(@(-15));
                make.height.equalTo(@44);
            }];
            [self layoutIfNeeded];
        }];
    });
    
    UIView *vBg = [[UIView alloc] init];
    vBg.backgroundColor = WhiteColor;
    [self addSubview:vBg];
    [vBg setCornerRadius:5];
    [vBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.bottom.equalTo(btn.mas_top).offset(-15);
    }];
    
    YXYLabel *lblTitle = [[YXYLabel alloc] init];
    lblTitle.title(@"筛选").color(Color_3).titleFont(Font_PingFang_Medium(16));
    [vBg addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@15);
    }];
    
    YXYLabel *minValue = [[YXYLabel alloc] init];
    minValue.title(@"12岁").titleFont(Font_PingFang_Medium(12)).color(Color_3);
    [vBg addSubview:minValue];
    
    YXYLabel *maxValue = [[YXYLabel alloc] init];
    maxValue.title(@"50岁").titleFont(Font_PingFang_Medium(12)).color(Color_3);
    [vBg addSubview:maxValue];
    
    SDRangeSliderView *slider = [[SDRangeSliderView alloc] initWithFrame:CGRectMake(62, 50, kScreenWidth - (62 + 15) * 2, 28)];
    slider.backgroundColor = WhiteColor;
    slider.lineColor = Color_E;;
    slider.highlightLineColor = ColorWithHex(@"30d7bd");
    slider.minValue = 12;
    slider.maxValue = 50;
    [vBg addSubview:slider];

    [minValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(slider);
        make.right.equalTo(slider.mas_left).offset(-15);
    }];
    [maxValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.centerY.equalTo(slider);
        make.left.equalTo(slider.mas_right).offset(15);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblTitle.mas_bottom).offset(17);
        make.height.equalTo(@28);
        make.centerX.equalTo(vBg);
        make.left.equalTo(minValue.mas_right).offset(15);
        make.right.equalTo(maxValue.mas_left).offset(-15);
    }];
    
    [slider customUIUsingBlock:^(UIButton *leftCursor, UIButton *rightCursor) {
        leftCursor.layer.borderColor = ColorWithHex(@"30d6c1").CGColor;
        leftCursor.layer.borderWidth = 3;
        rightCursor.layer.borderColor = ColorWithHex(@"30d6c1").CGColor;
        rightCursor.layer.borderWidth = 3;
        [leftCursor setCornerRadius:14];
        [rightCursor setCornerRadius:14];
        leftCursor.adjustsImageWhenHighlighted = NO;
        rightCursor.adjustsImageWhenHighlighted = NO;
    }];
    [self extracted:maxValue minValue:minValue slider:slider];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = Color_E;
    [v setCornerRadius:18];
    [vBg addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@23);
        make.right.equalTo(@(-23));
        make.centerX.equalTo(vBg);
        make.height.equalTo(@36);
        make.top.equalTo(slider.mas_bottom).offset(20);
        make.bottom.equalTo(@(-25));
    }];
    YXYButton *btnBoy = [[YXYButton alloc] init];
    [btnBoy.title(@"只看男", UIControlStateNormal).titleFont(Font_PingFang_Medium(12)).color(WhiteColor, UIControlStateNormal) addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnBoy.backgroundColor = Color_Main;
    self.btnSelected = btnBoy;
    [v addSubview:btnBoy];
    YXYButton *btnGirl = [[YXYButton alloc] init];
    [btnGirl.title(@"只看女", UIControlStateNormal).titleFont(Font_PingFang_Medium(12)).color(Color_9, UIControlStateNormal) addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnGirl];
    YXYButton *btnAll = [[YXYButton alloc] init];
    [btnAll.title(@"不限", UIControlStateNormal).titleFont(Font_PingFang_Medium(12)).color(Color_9, UIControlStateNormal) addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btnAll];
    [self layoutIfNeeded];

    [btnBoy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(v);
        make.left.equalTo(v);
        make.centerY.equalTo(v);
        make.width.equalTo(@(v.yxy_w / 3));
    }];
    [btnGirl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(v);
        make.left.equalTo(btnBoy.mas_right);
        make.centerY.equalTo(v);
        make.width.equalTo(@(v.yxy_w / 3));
    }];
    [btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(v);
        make.left.equalTo(btnGirl.mas_right);
        make.centerY.equalTo(v);
        make.width.equalTo(@(v.yxy_w / 3));
    }];
}

- (void)btnClicked:(YXYButton *)btn{
    if (btn == self.btnSelected) return;
    
    btn.color(WhiteColor, UIControlStateNormal).backgroundColor = Color_Main;
    self.btnSelected.color(Color_9, UIControlStateNormal).backgroundColor = Color_E;
    self.btnSelected = btn;
}


- (void)confirmClicked{
    if (self.FilterBlock) {
        self.FilterBlock(self.minValue, self.maxValue, self.btnSelected.currentTitle);
    }
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:.25 animations:^{
        [self setNeedsLayout];
        [self.btnConfirm mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(159 + 15 + 44 + 20 + HOME_INDICATOR_HEIGHT));
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
