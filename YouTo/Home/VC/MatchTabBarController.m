//
//  MatchTabBarController.m
//  YouTo
//
//  Created by apple on 2018/11/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchTabBarController.h"
#import "MatchController.h"
#import "YXYGCDTimer.h"

@interface MatchTabBarController ()

@property (nonatomic, strong) YXYGCDTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) YXYLabel *lblSearch;
@property (nonatomic, strong) UIImageView *imgVBg;
@property (nonatomic, strong) YXYButton *btnCancel;

@property (nonatomic, strong) UIButton *btnBack;

@property (nonatomic, strong) YXYLabel *lblTitle;

@end

@implementation MatchTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setMatchingUI];
    [self setUI];
}

- (void)setMatchingUI{
    
    UIImageView *imgVBg = [UIImageView new];
    imgVBg.image = LoadImageWithName(@"home_match_bg");
    [Self_View addSubview:imgVBg];
    [imgVBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(Self_View);
    }];
    self.imgVBg = imgVBg;
    
    YXYButton *btnCancel = YXYButton.new;
    [btnCancel setCornerRadius:22];
    self.btnCancel = btnCancel;
    btnCancel.title(@"取消匹配", UIControlStateNormal).titleFont(Font_PingFang_Medium(15)).color(UIColor.whiteColor, UIControlStateNormal);
    btnCancel.layer.borderWidth = 1;
    btnCancel.layer.borderColor = ColorWithHex(@"#54dada").CGColor;
    [btnCancel addTarget:self action:@selector(cancelMatchClicked) forControlEvents:UIControlEventTouchUpInside];
    [Self_View addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Self_View);
        make.height.equalTo(@44);
        make.width.equalTo(@140);
        make.bottom.equalTo(@(-TAB_BAR_HEIGHT - 30));
    }];
    
    YXYLabel *lbl = YXYLabel.new;
    self.lblSearch = lbl;
    lbl.titleFont(Font(16)).color(UIColor.whiteColor).title(@"原来你也在这里.");
    [Self_View addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(Self_View);
        make.top.equalTo(@(NAVIGATION_BAR_HEIGHT + 20));
    }];
    
    self.timer = [YXYGCDTimer initWithSelector:@selector(animationSearch) target:self timeInterval:0.8];
//    self.refreshDelegate = self.interactor;
    //    [self.tableView.mj_header beginRefreshing];
//    [self.refreshDelegate YXYVC_PullDownRefreshCompletion:^(BOOL success) {
//        [self setMatchedUI];
//    }];
}

- (void)animationSearch{
    self.count++;
    NSString *str = @"";
    for (int i = 0; i < self.count; i++) {
        str = [str stringByAppendingString:@"."];
    }
    self.lblSearch.title([@"原来你也在这里" stringByAppendingString:str]);
    
    if (self.count > 4)  self.count = 0;
}


- (void)setUI{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    [self setTabBarFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth / 4, 44)
        contentViewFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 44, kScreenWidth, self.view.yxy_h - 44 - NAVIGATION_BAR_HEIGHT)];
    
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
    
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    MatchController *vc1 = [[MatchController alloc] init];
    vc1.type = MatchControllerTypeUser;
    vc1.yp_tabItemTitle = @"用户";
    
    MatchController *vc2 = [[MatchController alloc] init];
    vc2.type = MatchControllerTypeGroup;
    vc2.yp_tabItemTitle = @"群组";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:vc1, vc2, nil];
    
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
        _lblTitle = [YXYLabel new];
        _lblTitle.titleFont(Font_PingFang_Medium(18)).color(Color_3).title(@"灵魂匹配");
    }
    return _lblTitle;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelMatchClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
