//
//  MessageTabBarController.m
//  YouTo
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MessageTabBarController.h"
#import <RongIMKit/RongIMKit.h>
#import "MessageListController.h"
#import "AttentionListController.h"
#import "PopView.h"

@interface MessageTabBarController ()

@property (nonatomic, strong) UIImageView *imgVTip;
@property (nonatomic, strong) YXYButton *btnAdd;
@property (nonatomic, strong) YXYButton *btnTipSys;

@end

@implementation MessageTabBarController

- (void)dealloc{
    RemoveNotifiObserver(self);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UINavigationBar appearance] setTintColor:WhiteColor];
    [[UINavigationBar appearance] setBarTintColor:WhiteColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.tabBarItem.badgeValue = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [RCIM sharedRCIM];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    [self setRightUI];
    AddNotifiObserver(self, @"showMsgTip", Msg_Tip, nil);
}

- (void)setUI{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];

    [self setTabBarFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 20, kScreenWidth / 3, 30)
        contentViewFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 20 + 40, kScreenWidth, self.view.yxy_h - 40 - STATUS_BAR_HEIGHT - 20 - TAB_BAR_HEIGHT)];
    
    self.tabBar.itemTitleColor = Color_3;
    self.tabBar.itemTitleSelectedColor = Color_3;
    self.tabBar.itemTitleSelectedFont = Font_PingFang_Bold(18);
    self.tabBar.itemTitleFont = Font_PingFang_Medium(14);
    [self.tabBar setIndicatorCornerRadius:2];
    self.tabBar.trailingSpace = 10;
    self.tabBar.indicatorScrollFollowContent = YES;
    self.tabBar.itemColorChangeFollowContentScroll = YES;
    self.tabBar.itemContentHorizontalCenter = NO;
    
    self.tabBar.indicatorColor = Color_Main;
    [self.tabBar setIndicatorWidth:20 marginTop:40 marginBottom:0 tapSwitchAnimated:YES];
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(26, 10, 0, 20) tapSwitchAnimated:YES];
    self.tabBar.indicatorAnimationStyle = YPTabBarIndicatorAnimationStyle1;
    
    //    [self.tabContentView setContentScrollEnabled:YES tapSwitchAnimated:NO];
    [self.yp_tabItem setDoubleTapHandler:^{
        NSLog(@"双击效果");
    }];
    
    MessageListController *controller1 = [[MessageListController alloc] initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE)] collectionConversationType:nil];
    controller1.yp_tabItemTitle = @"用户";
    
    MessageListController *controller2 = [[MessageListController alloc] initWithDisplayConversationTypes:@[@(ConversationType_GROUP)] collectionConversationType:nil];
    controller2.yp_tabItemTitle = @"群组";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, nil];
}

- (void)setRightUI{
    [self.view addSubview:self.btnAdd];
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tabBar);
        make.right.equalTo(@(-15));
    }];
    
    YXYButton *btnTip = [[YXYButton alloc] init];
    btnTip.bgImgae(LoadImageWithName(@"msg_system"), UIControlStateNormal);
    self.btnTipSys = btnTip;
    [btnTip addTarget:self action:@selector(msgClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTip];
    [btnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnAdd);
        make.right.equalTo(self.btnAdd.mas_left).offset(-30);
    }];
    [btnTip addSubview:self.imgVTip];
    [self.imgVTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@(-2));
    }];
}

- (void)btnAddClicked{
    if (self.tabBar.selectedItemIndex) {
        [PopView popWithDataSource:@[@"创建群", @"查找群"] imageDataSource:@[@"group_create", @"group_find"] baseView:self.btnAdd completion:^(NSInteger idx) {
            if (idx) {
                PushVCWithClassName(@"SearchGroupController");
            }else{
                PushVCWithClassName(@"CreateGroupController");
            }
        }];
    }else{
        self.imgVTip.hidden = YES;
        PushVCWithClassName(@"NotifiController");
    }
}

- (void)showMsgTip{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imgVTip.hidden = NO;
        [UserDefaults removeObjectForKey:Msg_Tip];
        self.tabBarItem.badgeValue = @"";
    });
}

- (void)msgClicked{
    self.imgVTip.hidden = YES;
    PushVCWithClassName(@"NotifiController");
}

- (void)tabContentView:(YPTabContentView *)tabConentView willSelectTabAtIndex:(NSUInteger)index{
    self.btnAdd.bgImgae(LoadImageWithName(index? @"msg_add_group" : @"msg_system"), UIControlStateNormal);
    self.btnTipSys.hidden = !index;
}

- (YXYButton *)btnAdd{
    if (!_btnAdd) {
        _btnAdd = [[YXYButton alloc] init];
        [_btnAdd.bgImgae(LoadImageWithName(@"msg_add_user"), UIControlStateNormal) addTarget:self action:@selector(btnAddClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

- (UIImageView *)imgVTip{
    if (!_imgVTip) {
        _imgVTip = [[UIImageView alloc] initWithImage:LoadImageWithName(@"msg_tip")];
        if ([UserDefaults objectForKey:Msg_Tip]) {
            _imgVTip.hidden = ![[UserDefaults objectForKey:Msg_Tip] boolValue];
            [UserDefaults removeObjectForKey:Msg_Tip];
        }else{
            _imgVTip.hidden = YES;
        }
    }
    return _imgVTip;
}
@end
