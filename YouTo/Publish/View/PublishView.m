//
//  PublishView.m
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PublishView.h"
#import "PublishController.h"

@implementation PublishView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.backgroundColor = WhiteColor;
    self.alpha = 0.98;
    
    UIButton *btnClose = [UIButton new];
    [btnClose setImage:LoadImageWithName(@"publish_close") forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClose];
    [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom);
    }];
    
    YXYButton *btnMood = YXYButton.new;
    btnMood.bgImgae(LoadImageWithName(@"publish_mood"), UIControlStateNormal);
    [btnMood addTarget:self action:@selector(btnPushlishMoodClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnMood];
    YXYButton *mood = YXYButton.new;
    mood.title(@"发布心情", UIControlStateNormal).color(Color_3, UIControlStateNormal).titleFont(Font_PingFang_Medium(14));
    [mood addTarget:self action:@selector(btnPushlishMoodClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mood];
    [mood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
    }];
    [btnMood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mood);
        make.top.equalTo(self.mas_bottom);
    }];
    
    YXYButton *btnHelp = YXYButton.new;
    btnHelp.bgImgae(LoadImageWithName(@"publish_help"), UIControlStateNormal);
    [btnHelp addTarget:self action:@selector(btnPushlishHelpClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnHelp];
    YXYButton *help = YXYButton.new;
    help.title(@"发布求助", UIControlStateNormal).color(Color_3, UIControlStateNormal).titleFont(Font_PingFang_Medium(14));
    [help addTarget:self action:@selector(btnPushlishHelpClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:help];
    [help mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
    }];
    [btnHelp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setNeedsLayout];
            [btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(@(-39 - HOME_INDICATOR_HEIGHT));
                make.width.height.equalTo(@40);
            }];
            [mood mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(btnClose.mas_top).offset(-60);
                make.left.equalTo(@55);
            }];
            [btnMood mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(mood);
                make.bottom.equalTo(mood.mas_top).offset(10);
            }];
            [help mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(btnClose.mas_top).offset(-60);
                make.right.equalTo(@(-55));
            }];
            [btnHelp mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(help);
                make.bottom.equalTo(help.mas_top).offset(10);
            }];
            [self layoutIfNeeded];
        } completion:nil];
    });
}

- (void)close{
    [self removeFromSuperview];
}

- (void)btnPushlishMoodClicked{
    [self close];
    PublishController *vc = PublishController.new;
    vc.type = PublishControllerTypeMood;
    [CurrentVC presentViewController:vc animated:YES completion:nil];
}

- (void)btnPushlishHelpClicked{
    [self close];
    PublishController *vc = PublishController.new;
    vc.type = PublishControllerTypeHelp;
    [CurrentVC presentViewController:vc animated:YES completion:nil];
}

@end
