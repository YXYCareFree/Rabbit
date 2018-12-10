//
//  PushNotificationManager.h
//  趣睡
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface PushNotificationManager : NSObject<UNUserNotificationCenterDelegate>

+ (instancetype)shareManager;

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;


@end
