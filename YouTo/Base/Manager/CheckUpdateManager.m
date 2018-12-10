//
//  CheckUpdateManager.m
//  趣睡
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "CheckUpdateManager.h"

@implementation CheckUpdateManager

+ (void)checkUpdate{
    // 获取本地版本号
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
//    NetWork  *network = [[NetWork alloc]init];
//    [network netWorkWithPost:API_upVersion params:[NSDictionary dictionaryWithObjectsAndKeys:currentVersion,@"version",@"ios",@"deviceType",@"member",@"target", nil] viewController:nil success:^(id responseObject) {
//        
//        if ([[responseObject valueForKey:@"resultCode"] integerValue] == 200) {
//            NSDictionary *dict = [responseObject valueForKey:@"resultContent"];
//            if (![dict[@"isNew"] boolValue]) {
//                
//                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，请问是否更新" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//                if (![dict[@"isForcedUpdate"] boolValue]) {
//                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不需要" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    [alertVc addAction:action1];
//                }
//                
//                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                    //跳转到AppStore，该App下载界面
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1403258332?mt=8"]];
////                    exit(0);
//                }];
//                [alertVc addAction:action2];
//                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
//            }
//        }
//            
//    } failed:nil];
}

@end
