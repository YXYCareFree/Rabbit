//
//  SettingController.m
//  YouTo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SettingController.h"
#import "SettingInteractor.h"
#import "LoginController.h"
#import "YXYNavigationController.h"
#import "UserModel.h"
#import <RongIMKit/RongIMKit.h>
#import "YXYAlertView.h"

@interface SettingController ()

@property (nonatomic, strong) SettingInteractor *interactor;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    self.lblTitle.text = @"设置";
    self.tableView.delegate = self.interactor;
    self.tableView.dataSource = self.interactor;
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"MineCellID"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    YXYButton *btn = YXYButton.new;
    [btn addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    btn.title(@"退出登录", UIControlStateNormal).titleFont(Font_PingFang_Medium(16)).color(Color_Main, UIControlStateNormal);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = Color_Main.CGColor;
    [btn setCornerRadius:20];
    [footer addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footer);
        make.width.equalTo(@145);
        make.height.equalTo(@40);
        make.bottom.equalTo(@0);
    }];
    self.tableView.tableFooterView = footer;
}

- (void)exitLogin{
    [YXYAlertView customAlertMessage:@"是否确认要退出登录？" confirmTitle:@"确认" confirmColor:Color_Main cancelTitle:@"取消" cancelColor:Color_Main completion:^(BOOL isConfirm) {
        if (isConfirm) {
            [UserModel clearUserInfo];
            [[RCIM sharedRCIM] logout];
            KEY_WINDOW.rootViewController = [[YXYNavigationController alloc] initWithRootViewController:LoginController.new];
        }
    }];
}

- (SettingInteractor *)interactor{
    if (!_interactor) {
        _interactor = SettingInteractor.new;
    }
    return _interactor;
}
@end
