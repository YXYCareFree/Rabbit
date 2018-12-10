//
//  ThirdPartServiceManager.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ThirdPartServiceManager.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation ThirdPartServiceManager

+ (void)registerService:(NSDictionary *)launchOptions{
   
    [UserDefaults setObject:@([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) forKey:@"isInatallWX"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HideNavBarVC" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    [UserDefaults setObject:arr forKey:@"YXYHideNavBarVC"];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"YXYForbidPanGesture" ofType:@"plist"];
    NSArray *arr1 = [NSArray arrayWithContentsOfFile:path1];
    [UserDefaults setObject:arr1 forKey:@"YXYForbidPanGesture"];
    
    [AMapServices sharedServices].apiKey = @"8e57807e75a204026d51fe75d15df185";

//    [UMConfigure setLogEnabled:YES];
    [UMConfigure setLogEnabled:NO];

    [UMConfigure initWithAppkey:@"5be104b6b465f50533000017" channel:@"App Store"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxc24d665aa39d5d3d" appSecret:@"3b34544115ecd237d3a57f880c40205b" redirectURL:@"http://mobile.umeng.com/social"];
}
@end
