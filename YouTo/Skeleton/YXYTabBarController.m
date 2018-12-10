//
//  YXYTabBarController.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYTabBarController.h"
#import "YXYNavigationController.h"
#import "HomeController.h"
#import "CityController.h"
#import "PublishController.h"
//#import "MessageController.h"
#import "MessageTabBarController.h"
#import "MineController.h"
#import "PublishView.h"
#import "CityTabBarController.h"

@interface YXYTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YXYTabBarController

+ (void)load{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName]= [UIFont systemFontOfSize:12];
    dic[NSForegroundColorAttributeName] = Color_3;
    if (@available(iOS 10.0, *)) {
        [item setBadgeTextAttributes:dic forState:UIControlStateNormal];
    } else {
        // Fallback on earlier versions
    }
    NSMutableDictionary *selAttrTitle = [NSMutableDictionary dictionary];
    selAttrTitle[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selAttrTitle[NSForegroundColorAttributeName] = Color_3;
    [item setTitleTextAttributes:selAttrTitle forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTabBarStyle];
    [self setUI];
}

- (void)setUI{
    YXYNavigationController *homeNav = [[YXYNavigationController alloc] initWithRootViewController:HomeController.new];
    [homeNav setTabbarTitle:@"遇见" normalImage:LoadImageWithName(@"tabbar_home_normal") selectedImage:LoadImageWithName(@"tabbar_home_selected")];
    
//    YXYNavigationController *cityNav = [[YXYNavigationController alloc] initWithRootViewController:[CityController new]];
    YXYNavigationController *cityNav = [[YXYNavigationController alloc] initWithRootViewController:[CityTabBarController new]];
    [cityNav setTabbarTitle:@"城市" normalImage:LoadImageWithName(@"tabbar_city_normal") selectedImage:LoadImageWithName(@"tabbar_city_selected")];

    YXYNavigationController *publishNav = [[YXYNavigationController alloc] initWithRootViewController:[PublishController new]];
    [publishNav setTabbarTitle:@"" normalImage:[LoadImageWithName(@"tabbar_publish") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:LoadImageWithName(@"tabbar_publish")];
    publishNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    YXYNavigationController *msgNav = [[YXYNavigationController alloc] initWithRootViewController:[MessageTabBarController new]];
    [msgNav setTabbarTitle:@"消息" normalImage:LoadImageWithName(@"tabbar_msg_normal") selectedImage:LoadImageWithName(@"tabbar_msg_selected")];
    
    YXYNavigationController *mineNav = [[YXYNavigationController alloc] initWithRootViewController:[MineController new]];
    [mineNav setTabbarTitle:@"我的" normalImage:LoadImageWithName(@"tabbar_mine_normal") selectedImage:LoadImageWithName(@"tabbar_mine_selected")];
    self.viewControllers = @[homeNav, cityNav, publishNav, msgNav, mineNav];
    
    self.delegate = self;
}

- (void)setTabBarStyle{
    
    [[UITabBar appearance] setShadowImage:UIImage.new];
    [[UITabBar appearance] setBackgroundImage:UIImage.new];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.tabBar.layer.shadowOpacity = 0.3;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[YXYNavigationController class]]) {
        if ([((YXYNavigationController *)viewController).topViewController isKindOfClass:[PublishController class]]) {
            PublishView *view = [[PublishView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [KEY_WINDOW addSubview:view];
            return NO;
        }
    }
    return YES;
}
@end
