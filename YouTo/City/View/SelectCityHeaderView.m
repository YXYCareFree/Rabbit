//
//  SelectCityHeaderView.m
//  YouTo
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectCityHeaderView.h"

@implementation SelectCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.lblTitle];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@20);
        make.bottom.equalTo(@(-10));
    }];
    
    [self addSubview:self.btnCity];
    [self.btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.centerY.equalTo(self.lblTitle);
    }];
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [[YXYLabel alloc] init];
    }
    return _lblTitle;
}

- (YXYButton *)btnCity{
    if (!_btnCity) {
        _btnCity = [[YXYButton alloc] init];
    }
    return _btnCity;
}
@end
