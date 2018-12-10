//
//  WarmHeartTabBarController.m
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WarmHeartTabBarController.h"
#import "WarmHeartListController.h"

@interface WarmHeartTabBarController ()

@property (nonatomic, strong) UIButton *btnBack;

@property (nonatomic, strong) YXYLabel *lblTitle;

@end

@implementation WarmHeartTabBarController

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    [self setTabBarFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 20, kScreenWidth, 44)
        contentViewFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 44 + 20, kScreenWidth, self.view.yxy_h - 44 - 20 - NAVIGATION_BAR_HEIGHT)];
    
    self.tabBar.itemTitleColor = Color_3;
    self.tabBar.itemTitleSelectedColor = Color_3;
    self.tabBar.itemTitleSelectedFont = Font_PingFang_Bold(18);
    self.tabBar.itemTitleFont = Font_PingFang_Medium(14);
    [self.tabBar setIndicatorCornerRadius:2];
    self.tabBar.trailingSpace = 200;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    self.tabBar.itemContentHorizontalCenter = NO;
    
    self.tabBar.indicatorColor = Color_Main;
    [self.tabBar setIndicatorWidth:24 marginTop:40 marginBottom:0 tapSwitchAnimated:YES];
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 20) tapSwitchAnimated:YES];
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    //    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    WarmHeartListController *controller1 = [[WarmHeartListController alloc] init];
    controller1.type = WarmHeartListControllerTypeAllCountry;
    controller1.yp_tabItemTitle = @"全国";
    
    WarmHeartListController *controller2 = [[WarmHeartListController alloc] init];
    controller2.type = WarmHeartListControllerTypeCity;
    controller2.yp_tabItemTitle = GetCity;
    
    WarmHeartListController *controller3 = [[WarmHeartListController alloc] init];
    controller3.type = WarmHeartListControllerTypeForegin;
    controller3.yp_tabItemTitle = @"境外";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];

    YXYLabel *lbl1 = YXYLabel.new;
    lbl1.title(@"根据精选回答数量排序").titleFont(Font(12)).color(Color_6);
    [self.view addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT));
        make.centerX.equalTo(self.view);
    }];

    [self.view addSubview:self.lblTitle];
    [self.view addSubview:self.btnBack];
    [self.btnBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STATUS_BAR_HEIGHT));
        make.width.height.equalTo(@44);
        make.left.equalTo(@20);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(STATUS_BAR_HEIGHT));
        make.height.equalTo(@44);
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton new];
        [_btnBack setImage:LoadImageWithName(@"back_gray") forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [[YXYLabel alloc] init];
        _lblTitle.titleFont(Font_PingFang_Medium(18)).color(Color_3).title(@"热心榜");
    }
    return _lblTitle;
}
@end
