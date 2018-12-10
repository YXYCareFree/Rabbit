//
//  CityHeaderView.m
//  YouTo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityHeaderView.h"
#import "LoginAdapter.h"
#import "SelectCityView.h"
#import "UIButton+WebCache.h"
#import "CityCommonAdapter.h"

@interface CityHeaderView ()

@property (nonatomic, strong) YXYButton *btnCity1;
@property (nonatomic, strong) YXYLabel *lblDetail;
@property (nonatomic, strong) YXYButton *btnLike;
@property (nonatomic, strong) YXYLabel *lblNum;

@property (nonatomic, strong) UIImageView *imgV1;
@property (nonatomic, strong) UIImageView *imgV2;
@property (nonatomic, strong) UIImageView *imgV3;

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) YXYButton *btnHot;

@end

@implementation CityHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setModel:(CityAbstractModel *)model{
    if (!model) return;
    
    _model = model;

    self.lblDetail.text = model.showInfo;
    [self.btnLike setImage:LoadImageWithName(model.isLike ? @"city_like" : @"city_unlike_white") forState:UIControlStateNormal];
    self.lblNum.text = model.likeNum;
    for (NSInteger i = 0; i < model.hotMember.count; i++) {
        HotMemberModel *member = model.hotMember[i];
        if (i == 0) {
            [self addSubview:self.imgV1];
            [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.btnHot.mas_left).offset(-10);
                make.centerY.equalTo(self.btnHot);
                make.height.width.equalTo(@28);
            }];
            
            [self.imgV1 sd_setImageWithURL:URLWithStr(member.headImg) placeholderImage:PlaceHolderImage];
        }
        if (i == 1) {
            [self addSubview:self.imgV2];
            [self.imgV2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.imgV1.mas_left).offset(10);
                make.centerY.equalTo(self.btnHot);
                make.height.width.equalTo(@28);
            }];
            [self.imgV2 sd_setImageWithURL:URLWithStr(member.headImg) placeholderImage:PlaceHolderImage];
        }
        if (i == 2) {
            [self addSubview:self.imgV3];
            [self.imgV3 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.imgV2.mas_left).offset(10);
                make.centerY.equalTo(self.btnHot);
                make.height.width.equalTo(@28);
            }];
            [self.imgV3 sd_setImageWithURL:URLWithStr(member.headImg) placeholderImage:PlaceHolderImage];
        }
    }
}

- (void)setUI{

    [self addSubview:self.imgV];
    [self addSubview:self.btnCity];
    [self addSubview:self.btnCity1];
    [self addSubview:self.lblDetail];
    [self addSubview:self.btnLike];
    [self addSubview:self.lblNum];

    [self.btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STATUS_BAR_HEIGHT + 10));
        make.left.equalTo(@15);
    }];
    [self.btnCity1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCity.mas_right).offset(3);
        make.centerY.equalTo(self.btnCity);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCity.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
    }];
    
    [self.btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCity.mas_bottom).offset(98);
        make.left.equalTo(@15);
        make.height.equalTo(@(15.5));
        make.bottom.equalTo(@(-20));
    }];
    [self.lblNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnLike);
        make.left.equalTo(self.btnLike.mas_right).offset(10);
    }];
    YXYLabel *lbl = [[YXYLabel alloc] init];
    lbl.title(@"人喜欢这个城市").titleFont(Font_PingFang_Medium(11)).color(WhiteColor);
    [self addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblNum.mas_right).offset(2);
        make.centerY.equalTo(self.lblNum);
    }];
    
    YXYButton *btn = [[YXYButton alloc] init];
    [btn.setImgae(LoadImageWithName(@"arrow_right_white"), UIControlStateNormal) addTarget:self action:@selector(warmHeartClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.btnLike);
    }];
    YXYButton *btn1 = [[YXYButton alloc] init];
    self.btnHot = btn1;
    btn1.titleFont(Font_PingFang_Medium(14)).color(WhiteColor, UIControlStateNormal).title(@"热心榜", UIControlStateNormal);
    [btn1 addTarget:self action:@selector(warmHeartClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-5);
        make.centerY.equalTo(self.btnLike);
    }];
}

- (void)changeCity{
    if (self.SelectCityBlock) {
        self.SelectCityBlock(self.btnCity);
    }
}

- (void)btnLikeClicked:(YXYButton *)btn{
    if (self.model.isLike) {
        [CityCommonAdapter unlikeCity:^(BOOL success, id response) {
            if (success) {
                self.model.isLike = NO;
                self.model.likeNum = [NSString stringWithFormat:@"%ld", ([self.model.likeNum integerValue] - 1)];
                self.model = self.model;
            }
        }];
    }else{
        [CityCommonAdapter likeCity:^(BOOL success, id response) {
            if (success) {
                self.model.isLike = YES;
                self.model.likeNum = [NSString stringWithFormat:@"%ld", ([self.model.likeNum integerValue] + 1)];
                self.model = self.model;
            }
        }];
    }
}

- (void)warmHeartClicked{
    PushVCWithClassName(@"WarmHeartTabBarController");
}

- (YXYButton *)btnCity{
    if (!_btnCity) {
        _btnCity = [[YXYButton alloc] init];
        _btnCity.title(GetCity, UIControlStateNormal).color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Bold(21));
        [_btnCity addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCity;
}

- (YXYButton *)btnCity1{
    if (!_btnCity1) {
        _btnCity1 = [[YXYButton alloc] init];
        _btnCity1.setImgae(LoadImageWithName(@"pulldown_white"), UIControlStateNormal);
        [_btnCity1 addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCity1;
}

- (YXYLabel *)lblDetail{
    if (!_lblDetail) {
        _lblDetail = [[YXYLabel alloc] init];
        _lblDetail.titleFont(Font(13)).color(WhiteColor).numberOfLines = 3;
    }
    return _lblDetail;
}

- (YXYButton *)btnLike{
    if (!_btnLike) {
        _btnLike = [[YXYButton alloc] init];
        [_btnLike.setImgae(LoadImageWithName(@"city_unlike_white"), UIControlStateNormal) addTarget:self action:@selector(btnLikeClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLike;
}

- (YXYLabel *)lblNum{
    if (!_lblNum) {
        _lblNum = [[YXYLabel alloc] init];
        _lblNum.titleFont(Font_PingFang_Bold(15)).color(WhiteColor);
    }
    return _lblNum;
}

- (UIImageView *)imgV1{
    if (!_imgV1) {
        _imgV1 = [[UIImageView alloc] init];
        _imgV1.contentMode = UIViewContentModeScaleAspectFill;
        [_imgV1 setCornerRadius:14];
        _imgV1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warmHeartClicked)];
        [_imgV1 addGestureRecognizer:tap];
    }
    return _imgV1;
}

- (UIImageView *)imgV2{
    if (!_imgV2) {
        _imgV2 = [[UIImageView alloc] init];
        _imgV2.contentMode = UIViewContentModeScaleAspectFill;
        [_imgV2 setCornerRadius:14];
        _imgV2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warmHeartClicked)];
        [_imgV2 addGestureRecognizer:tap];
    }
    return _imgV2;
}

- (UIImageView *)imgV3{
    if (!_imgV3) {
        _imgV3 = [[UIImageView alloc] init];
        _imgV3.contentMode = UIViewContentModeScaleAspectFill;
        [_imgV3 setCornerRadius:14];
        _imgV3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warmHeartClicked)];
        [_imgV3 addGestureRecognizer:tap];
    }
    return _imgV3;
}

- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = YES;
        _imgV.image = LoadImageWithName(@"city_bg");
    }
    return _imgV;
}

@end
