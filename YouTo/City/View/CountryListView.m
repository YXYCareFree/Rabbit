//
//  CountryListView.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CountryListView.h"

@interface CountryListView ()

@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) YXYButton *btnSelected;
@end

@implementation CountryListView

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self addSubview:self.scr];
    [self addSubview:self.indicator];
    
    [self.scr.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    for (NSInteger i = 0; i < dataSource.count; i++) {
        YXYButton *btn = [[YXYButton alloc] initWithFrame:CGRectMake(0, 50 * i, 86, 50)];
        btn.titleFont(Font(16)).color(Color_3, UIControlStateNormal).title(dataSource[i], UIControlStateNormal);
        btn.tag = Tag_CityChange + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scr addSubview:btn];
        btn.backgroundColor = Color_E;
        if (i == 0) {
            _btnSelected = btn;
            _btnSelected.backgroundColor = WhiteColor;
            _btnSelected.titleFont(Font_PingFang_Bold(16));
        }
    }
}

- (void)btnClicked:(YXYButton *)btn{
    if (btn == _btnSelected) return;
    if (self.ListSelectedBlock) {
        self.ListSelectedBlock(btn.tag - Tag_CityChange);
    }
    _btnSelected.titleFont(Font(16));
     btn.titleFont(Font_PingFang_Bold(16));
    _btnSelected.backgroundColor = Color_E;
    btn.backgroundColor = WhiteColor;
    
    _btnSelected = btn;
    [self.indicator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(btn);
        make.height.equalTo(@20);
        make.width.equalTo(@4);
    }];
}

- (UIScrollView *)scr{
    if (!_scr) {
        _scr = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scr.showsVerticalScrollIndicator = NO;
    }
    return _scr;
}

- (UIView *)indicator{
    if (!_indicator) {
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 4, 20)];
        _indicator.backgroundColor = Color_Main;
        [_indicator setCornerRadius:2];
    }
    return _indicator;
}
@end
