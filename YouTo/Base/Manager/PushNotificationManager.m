//
//  PushNotificationManager.m
//  趣睡
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "PushNotificationManager.h"
#import <UMPush/UMessage.h>

@implementation PushNotificationManager

+ (instancetype)shareManager{
    static PushNotificationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PushNotificationManager new];
        UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
        //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
        entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
        if (@available(iOS 10.0, *)) {
            [UNUserNotificationCenter currentNotificationCenter].delegate = manager;
        } else {
            // Fallback on earlier versions
        }
        [UMessage registerForRemoteNotificationsWithLaunchOptions:nil Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
            }else  {
                
            }
        }];
    });
    return manager;
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    NSLog(@"%s %@", __FUNCTION__, userInfo);
    //定制自定的的弹出框
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification" object:nil];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
    }
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token=[NSString stringWithFormat:@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""]];
    NSLog(@"token ====%@",token);
//    [UserModel save_device_token:token];
    [UMessage registerDeviceToken:deviceToken];
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"%s %@", __FUNCTION__, userInfo);

    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        //定制自定的的弹出框
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification" object:nil];
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
        }else{
            NSLog(@"接收了消息");
        }
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"%s %@", __FUNCTION__, userInfo);
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
}
/**
 **
 {
 aps =     {
 alert =         {
 body = 1;
 subtitle = 1;
 title = 1;
 };
 badge = 1;
 sound = default;
 };
 d = umny3ld153139252084410;
 p = 0;
 sn = 10000101531205943538;
 }
 **
 */
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"%s %@", __FUNCTION__, userInfo);
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

@end
