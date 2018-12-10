//
//  AttentionTabBarController.m
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AttentionTabBarController.h"
#import "AttentionListController.h"

@implementation AttentionTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    [self setTabBarFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, 44)
        contentViewFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 44, kScreenWidth, self.view.yxy_h - 44 - NAVIGATION_BAR_HEIGHT)];
    
    self.tabBar.itemTitleColor = Color_3;
    self.tabBar.itemTitleSelectedColor = Color_3;
    self.tabBar.itemTitleSelectedFont = Font_PingFang_Bold(18);
    self.tabBar.itemTitleFont = Font_PingFang_Medium(14);
    [self.tabBar setIndicatorCornerRadius:2];
    self.tabBar.trailingSpace = 100;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    self.tabBar.itemContentHorizontalCenter = NO;
    
    self.tabBar.indicatorColor = Color_Main;
    [self.tabBar setIndicatorWidth:24 marginTop:40 marginBottom:0 tapSwitchAnimated:YES];
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 20) tapSwitchAnimated:YES];
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    AttentionListController *vc1 = [[AttentionListController alloc] init];
    vc1.type = AttentionListControllerTypeAttentionMe;
    vc1.yp_tabItemTitle = @"关注我的";
    
    AttentionListController *vc2 = [[AttentionListController alloc] init];
    vc2.type = AttentionListControllerTypeEachOther;
    vc2.yp_tabItemTitle = @"互相关注";
    
    AttentionListController *vc3 = [[AttentionListController alloc] init];
    vc3.type = AttentionListControllerTypeAttentionOther;
    vc3.yp_tabItemTitle = @"我的关注";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:vc1, vc2, vc3, nil];
    
    [self.view addSubview:self.lblTitle];
    [self.view addSubview:self.btnBack];
    [self.btnBack mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STATUS_BAR_HEIGHT));
        make.width.height.equalTo(@44);
        make.left.equalTo(@15);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(STATUS_BAR_HEIGHT));
        make.height.equalTo(@44);
    }];
}

- (UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton new];
        [_btnBack setImage:LoadImageWithName(@"back_gray") forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _btnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _btnBack;
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [YXYLabel new];
        _lblTitle.titleFont(Font_PingFang_Medium(18)).color(Color_3).title(@"关注");
    }
    return _lblTitle;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
