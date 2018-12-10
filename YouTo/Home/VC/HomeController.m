//
//  HomeController.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "HomeController.h"
#import "LocationManager.h"
#import "LoginAdapter.h"
#import "SelectCityView.h"
#import "HomeAnimationView.h"
#import "AccountManager.h"
#import "UserInfoController.h"
#import "MatchAdapter.h"
#import "FilterView.h"
#import "NSObject+YYModel.h"
#import "SelectCityController.h"

@interface HomeController ()

@property (nonatomic, strong) YXYButton *btnCity;
@property (nonatomic, strong) HomeAnimationView *vAnimation;
@property (nonatomic, strong) NSArray *matchData;
@property (nonatomic, strong) NSString *filterStr;

@property (nonatomic, strong) UIImageView *imgV1;
@property (nonatomic, strong) UIImageView *imgV2;

@end

@implementation HomeController

- (void)dealloc{
    RemoveNotifiObserver(self);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.vAnimation stopScan];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.btnCity.title(GetCity, UIControlStateNormal);
    self.vAnimation.roundImgGroup = self.matchData;
    UserModel *model = [AccountManager getUserInfo];
    self.vAnimation.centerImgUrl = model.headImg;
    [self.vAnimation startScan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    AddNotifiObserver(self, @"setMatchUI", ChangeCity, nil);
    [self setNavBarUI];
    [self setBottomView];
    [self setMatchUI];
}

-(void)setMatchUI{
    [MatchAdapter matchUserWithFilter:self.filterStr?:@"" completion:^(BOOL success, id response) {
        if (success) {
            self.matchData = response;
            [AccountManager refreshUserInfoWithParams:nil completion:^(UserModel * _Nonnull model) {
                [self.view addSubview:self.vAnimation];
                self.vAnimation.roundImgGroup = response;
                self.vAnimation.centerImgUrl = model.headImg;
            }];
        }
    }];
}

- (void)setNavBarUI{
    self.vBackHidden = YES;
    self.vNavBar.backgroundColor = WhiteColor;
    self.view.backgroundColor = UIColor.blackColor;
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[LoadImageWithName(@"login_logo") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    imgV.tintColor = Color_3;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.vNavBar addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.lblTitle);
        make.height.equalTo(@14);
        make.width.equalTo(@54);
    }];
    
    YXYButton *btn = [[YXYButton alloc] init];
    btn.title(@"筛选", UIControlStateNormal).color(Color_3, UIControlStateNormal).titleFont(Font_PingFang_Medium(14));
    [btn addTarget:self action:@selector(filterClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.lblTitle);
    }];
    
    YXYButton *btn1 = [[YXYButton alloc] init];
    [btn1.setImgae(LoadImageWithName(@"filter"), UIControlStateNormal) addTarget:self action:@selector(filterClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn);
        make.right.equalTo(btn.mas_left).offset(-3);
    }];
}

- (void)setBottomView{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:LoadImageWithName(@"home_city")];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.imgV1 = imgV;
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
    }];
    self.imgV2 = [[UIImageView alloc] initWithImage:LoadImageWithName(@"home_city")];
    self.imgV2.contentMode = UIViewContentModeScaleAspectFill;
    [Self_View addSubview:self.imgV2];
    [self.imgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgV1.mas_right);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(kScreenWidth));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.2];
    [view setCornerRadius:5];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-25));
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
    }];
    YXYButton *imgBtn = [[YXYButton alloc] init];
    imgBtn.setImgae(LoadImageWithName(@"home_location"), UIControlStateNormal);
    imgBtn.adjustsImageWhenHighlighted = NO;
    [view addSubview:imgBtn];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@19);
        make.left.equalTo(@39);
    }];
    YXYButton *btn = [[YXYButton alloc] init];
    btn.title(@"目的地", UIControlStateNormal).color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(18));
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBtn.mas_right).offset(4);
        make.centerY.equalTo(imgBtn);
    }];
    YXYButton *btnCity = [[YXYButton alloc] init];
    [btnCity.title(GetCity, UIControlStateNormal).color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(18)) addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnCity];
    self.btnCity = btnCity;
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgBtn);
        make.right.equalTo(@(-42));
    }];
    
    UIView *vSplit = [[UIView alloc] init];
    vSplit.backgroundColor = ColorWithHex(@"#9b866a");
    vSplit.alpha = 0.3;
    [view addSubview:vSplit];
    [vSplit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.equalTo(btnCity.mas_bottom).offset(15);
        make.left.right.equalTo(@0);
    }];
    YXYButton *btnMatch = [[YXYButton alloc] init];
    [btnMatch.title(@"旅行匹配", UIControlStateNormal).color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(18)) addTarget:self action:@selector(btnMatchCicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnMatch];
    [btnMatch setCornerRadius:22];
    btnMatch.backgroundColor = Color_Main;
    [btnMatch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-15));
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
        make.top.equalTo(vSplit.mas_bottom).offset(15);
    }];
}

- (void)filterClicked{
    [FilterView showFilterView:^(double min, double max, NSString *str) {
        NSLog(@"%f, %f, %@", min, max, str);
        NSString *sex = @"";
        if ([str isEqualToString:@"只看男"]) {
            sex = @"boy";
        }else if ([str isEqualToString:@"只看女"]){
            sex = @"girl";
        }else{
            sex = @"all";
        }
        NSDictionary *dict = @{@"sex": sex, @"minAge": @(min), @"maxAge": @(max)};
        self.filterStr = [dict yy_modelToJSONString];
        NSLog(@"%@", self.filterStr);
        [self setMatchUI];
    }];
}

- (void)btnMatchCicked{
    [self.vAnimation startAnimation];
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view setNeedsLayout];
        [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_left);
            make.bottom.equalTo(Self_View);
            make.width.equalTo(@(kScreenWidth));
        }];
        [Self_View layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.imgV1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)selectArea{
    SelectCityController *vc = [[SelectCityController alloc] initWithSelectCityBlock:^(NSString * _Nonnull code, NSString * _Nonnull city) {
        NSLog(@"%@, %@", city, code);
        if (city && city.length) {
            self.btnCity.title(city, UIControlStateNormal);
            [UserDefaults setObject:code forKey:Adcode];
            [UserDefaults setObject:@NO forKey:IsPosition];
            [UserDefaults setObject:city forKey:City];
            Notifi(ChangeCity, nil, nil);
        }
    }];
    PushVC(vc);
}

- (void)matchClicked{
//    PushVCWithClassName(@"MatchTabBarController");
    PushVCWithClassName(@"MatchController");
}

- (HomeAnimationView *)vAnimation{
    if (!_vAnimation) {
        UserModel *model = [AccountManager getUserInfo];
        _vAnimation = [[HomeAnimationView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, 450) centerImageUrl:model.headImg roundImageUrlGroup:@[]];
    }
    return _vAnimation;
}
@end
