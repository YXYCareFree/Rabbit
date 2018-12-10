//
//  CityTabBarController.m
//  YouTo
//
//  Created by apple on 2018/12/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityTabBarController.h"
#import "CityController.h"
#import "CityCell.h"
#import "CityTabBarInteractor.h"
#import "LoginAdapter.h"
#import "SelectCityView.h"
#import "SelectCityController.h"

@interface CityTabBarController ()

@property (nonatomic, strong) CityTabBarInteractor *interactor;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YXYButton *btnCity;

@end

@implementation CityTabBarController

-(void)dealloc{
    RemoveNotifiObserver(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.vBackHidden = YES;
    self.vNavBar.alpha = 0;
    self.vNavBar.backgroundColor = WhiteColor;
    [self setTableViewUI];
}

- (void)setTableViewUI{

    AddNotifiObserver(self, @"changeCityNotifi", ChangeCity, nil);
    YXYButton *btn = [[YXYButton alloc] init];
    self.btnCity = btn;
    btn.title(GetCity, UIControlStateNormal).color(Color_3, UIControlStateNormal).titleFont(Font_PingFang_Medium(18));
    [btn addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.lblTitle);
    }];
    YXYButton *btn1 = [[YXYButton alloc] init];
    btn1.setImgae(LoadImageWithName(@"pull_down"), UIControlStateNormal);
    [btn1 addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.left.equalTo(btn.mas_right).offset(2);
    }];
    
    self.headerView = [[CityHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 167 + STATUS_BAR_HEIGHT)];
    WEAKSELF;
    self.headerView.SelectCityBlock = ^(YXYButton * _Nonnull btn) {
        [weakSelf changeCity:btn];
    };
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.refreshDelegate = self.interactor;
    self.tableView.mj_footer = nil;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[CityCell class] forCellReuseIdentifier:@"CityCellID"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)changeCityNotifi{
    self.headerView.btnCity.title(GetCity, UIControlStateNormal);
    self.btnCity.title(GetCity, UIControlStateNormal);
    [self.tableView.mj_header beginRefreshing];
}

- (void)changeCity:(YXYButton *)btn{
    SelectCityController *vc = [[SelectCityController alloc] initWithSelectCityBlock:^(NSString * _Nonnull code, NSString * _Nonnull city) {
        NSLog(@"%@, %@", city, code);
        if (city && city.length) {
            btn.title(city, UIControlStateNormal);
            [UserDefaults setObject:code forKey:Adcode];
            [UserDefaults setObject:@NO forKey:IsPosition];
            [UserDefaults setObject:city forKey:City];
            Notifi(ChangeCity, nil, nil);
        }
    }];
    PushVC(vc);
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (CityTabBarInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[CityTabBarInteractor alloc] init];
        _interactor.vc = self;
        _interactor.pageNum = @"1";
    }
    return _interactor;
}

@end
