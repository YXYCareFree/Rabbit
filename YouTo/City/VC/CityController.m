//
//  CityController.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityController.h"
#import "CityCommonController.h"

@interface CityController ()

@property (nonatomic, strong) YXYButton *btnCity;
@property (nonatomic, strong) CityCommonController *vc1;
@property (nonatomic, strong) CityCommonController *vc2;
@property (nonatomic, strong) CityCommonController *vc3;
//@property (nonatomic, strong) CityCommonController *vc1;

@end

@implementation CityController

- (instancetype)initWithType:(CityContentType)type{
    if (self = [super init]) {
        [self setUI];
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    
    [self setTabBarFrame:CGRectMake(0, 0, kScreenWidth, 44)
        contentViewFrame:CGRectMake(0, 47, kScreenWidth, kScreenHeight - TAB_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - 47)];
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
    
    self.vc1 = [[CityCommonController alloc] init];
    self.vc1.type = CityContentTypeMood;
    self.vc1.yp_tabItemTitle = @"广场";
    
    self.vc2 = [[CityCommonController alloc] init];
    self.vc2.type = CityContentTypeHelp;
    self.vc2.yp_tabItemTitle = @"求助";
    
    self.vc3 = [[CityCommonController alloc] init];
    self.vc3.type = CityContentTypeNews;
    self.vc3.yp_tabItemTitle = @"资讯";
    
//    self.vc4 = [[CityCommonController alloc] init];
//    self.vc4.type = CityCommonControllerTypeStrategy;
//    self.vc4.yp_tabItemTitle = @"攻略";
    
    self.viewControllers = [NSMutableArray arrayWithObjects:self.vc1, self.vc2, self.vc3, nil];
}

- (void)setType:(CityContentType)type{
    _type = type;
    switch (type) {
        case CityContentTypeMood: self.tabContentView.defaultSelectedTabIndex = 0; break;
        case CityContentTypeHelp: self.tabContentView.defaultSelectedTabIndex = 1;  break;
        case CityContentTypeNews: self.tabContentView.defaultSelectedTabIndex = 2;  break;
        default: break;
    }
}

- (void)tabContentView:(YPTabContentView *)tabConentView willSelectTabAtIndex:(NSUInteger)index{
    if (self.ChangeCityContentBlock) {
        CityContentType type = CityContentTypeMood;
        switch (index) {
            case 1: type = CityContentTypeHelp; break;
            case 2: type = CityContentTypeNews; break;
            case 3: type = CityContentTypeTypeStrategy; break;
            default: break;
        }
//        self.type = type;
        self.ChangeCityContentBlock(type);
    }
}



@end
