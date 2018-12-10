//
//  MultiCityView.m
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MultiCityView.h"

@implementation MultiCityView

- (void)setDataSource:(NSMutableArray *)dataSource{
    if ([dataSource.firstObject isEqualToString:@""]) return;
    
    _dataSource = dataSource;
    [self setUI];
}

- (void)setUI{

    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat top = 0;
    CGFloat left = 0;

    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        NSString *city = self.dataSource[i];
        CGSize size = [city sizeWithAttributes:@{NSFontAttributeName: Font_PingFang_Medium(16)}];
        CityView *view = [[CityView alloc] initWithTitle:city];
        view.RemoveCityBlock = ^(NSString * _Nonnull city) {
            if (self.RemoveCity) {
                self.RemoveCity(city);
            }
        };
        [self addSubview:view];
        
        CGFloat width = size.width + 32;
        if ((left + width) > self.yxy_w) {
            top++;
            left = 0;
        }
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.top.equalTo(@(top * (size.height + 15)));
            if (i == self.dataSource.count - 1) {
                make.bottom.equalTo(@(0));
            }
        }];
        
        left += width;
    }
}

@end


@implementation CityView

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        [self setUIWithTitle:title];
    }
    return self;
}

- (void)setUIWithTitle:(NSString *)title{
    YXYLabel *lbl = YXYLabel.new;
    lbl.titleFont(Font_PingFang_Medium(16)).color(Color_3).title(title);
    [self addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
    }];
    
    YXYButton *btnClose = YXYButton.new;
    btnClose.setImgae(LoadImageWithName(@"login_close"), UIControlStateNormal);
    [btnClose addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClose];
    [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl.mas_right).offset(2);
        make.right.equalTo(@0);
        make.width.equalTo(@20);
        make.top.bottom.equalTo(@0);
    }];
}

- (void)remove{
    if (self.RemoveCityBlock) {
        self.RemoveCityBlock(self.title);
    }
    [self removeFromSuperview];
}

@end
