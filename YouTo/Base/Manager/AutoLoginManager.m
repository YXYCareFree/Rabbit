//
//  AutoLoginManager.m
//  YouTo
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AutoLoginManager.h"
#import "LoginAdapter.h"
#import "RCIMManager.h"
#import "FillUserNameController.h"
#import "AccountManager.h"
#import "YXYTabBarController.h"
#import "YXYNavigationController.h"
#import "LoginController.h"

@implementation AutoLoginManager

+ (void)autoLogin{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_async(dispatch_queue_create(0, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSString *str = [BASE_URL stringByAppendingFormat:@"%@", @"app/member/V1.0.0/tokenLogin"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URLWithStr(str)];
        request.HTTPMethod = @"POST";

        NSString *token = [NSString stringWithFormat:@"token=%@", [UserDefaults objectForKey:AccessToken]?:@""];
        request.HTTPBody = [token dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            if ([dict[@"code"] integerValue] == 200) {
                NSDictionary *dic = [dict valueForKey:@"data"];
                
                [UserDefaults setObject:[dic valueForKey:@"token"] forKey:AccessToken];
                if (![[dic valueForKey:@"isWriteInfo"] boolValue]) {
                    KEY_WINDOW.rootViewController = [[FillUserNameController alloc] init];
                }else{
                    KEY_WINDOW.rootViewController = [[YXYTabBarController alloc] init];
                    [AccountManager refreshUserInfoWithParams:nil completion:^(UserModel * _Nonnull model) {
                        [RCIMManager loginIM];
                    }];
                }
            }else{
                KEY_WINDOW.rootViewController = [[YXYNavigationController alloc] initWithRootViewController:[[LoginController alloc] init]];
            }

            dispatch_semaphore_signal(sema);
            NSLog(@"%@",dict);
        }];
        [task resume];
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end
