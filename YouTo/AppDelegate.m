//
//  AppDelegate.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "YXYTabBarController.h"
#import "ThirdPartServiceManager.h"
#import "PushNotificationManager.h"
#import "CheckUpdateManager.h"
#import "YXYNavigationController.h"
#import "UMSocialWechatHandler.h"
#import "AutoLoginManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [ThirdPartServiceManager registerService:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([UserDefaults objectForKey:AccessToken]) {
        [AutoLoginManager autoLogin];
    }else{
        self.window.rootViewController = [[YXYNavigationController alloc] initWithRootViewController:LoginController.new];
    }
    
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];

    [CheckUpdateManager checkUpdate];
    [PushNotificationManager shareManager];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [[UMSocialManager defaultManager] handleOpenURL:url];
    return YES;
}

#pragma mark 通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [PushNotificationManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [PushNotificationManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [PushNotificationManager application:application didReceiveRemoteNotification:userInfo];
}
@end
