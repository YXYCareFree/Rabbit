//
//  LoginInteractor.m
//  YouTo
//
//  Created by apple on 20.58/.5.5/6.
//  Copyright © 20.58年 apple. All rights reserved.
//

#import "LoginInteractor.h"
#import "NSString+RegularExpressions.h"
#import <UMShare/UMShare.h>
#import "LoginAdapter.h"
#import "YXYGCDTimer.h"
#import "AccountManager.h"
#import "YXYTabBarController.h"
#import "RCIMManager.h"

@interface LoginInteractor ()

@property (nonatomic, assign) NSInteger countDown;
@property (nonatomic, strong) YXYGCDTimer *timer;
@property (nonatomic, strong) NSString *openid;

@end

@implementation LoginInteractor

- (void)btnLoginClicked{
    NSString *phone = SelfVC.phoneTextField.textField.text;
    if (![phone isPhoneNumber]) {
        [MBProgressHUD showText:LocalizedString(@"请输入正确的手机号")];
        return;
    }
    if (SelfVC.type == Login) {
        MBProgressHUD *hud = [MBProgressHUD showLoadingWithText:@"正在登录..."];
        [LoginAdapter loginWithPhone:SelfVC.phoneTextField.textField.text authCode:SelfVC.authCodeTextField.textField.text completion:^(BOOL success, id response) {
            if (success) {
                hud.label.text = @"登录成功";
                [hud hideAnimated:YES afterDelay:.5];
                if ([response valueForKey:@"token"]) {
                    [UserDefaults setObject:[response valueForKey:@"token"] forKey:AccessToken];
                }
                if (![[response valueForKey:@"isWriteInfo"] boolValue]) {
                    PushVCWithClassName(@"FillUserNameController");
                }else{
                    [AccountManager refreshUserInfoWithParams:nil completion:^(UserModel * _Nonnull model) {
                        [RCIMManager loginIM];
                    }];
                    KEY_WINDOW.rootViewController = YXYTabBarController.new;
                }

            }else{
                hud.label.text = @"登录失败";
                [hud hideAnimated:YES afterDelay:.5];
            }
        }];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showLoadingWithText:@"正在绑定..."];
        [LoginAdapter loginByWXOpenid:self.openid phone:SelfVC.phoneTextField.textField.text authCode:SelfVC.authCodeTextField.textField.text completion:^(BOOL success, id response) {
            if (success) {
                if ([response valueForKey:@"token"]) {
                    [UserDefaults setObject:[response valueForKey:@"token"] forKey:AccessToken];
                }
                if (![[response valueForKey:@"isWriteInfo"] boolValue]) {
                    PushVCWithClassName(@"FillUserNameController");
                }else{
                    [AccountManager refreshUserInfoWithParams:nil completion:^(UserModel * _Nonnull model) {
                        [RCIMManager loginIM];
                    }];
                    KEY_WINDOW.rootViewController = [[YXYTabBarController alloc] init];
                }
                hud.label.text = @"绑定成功";
                [hud hideAnimated:YES afterDelay:.5];
            }else{
                hud.label.text = @"绑定失败";
                [hud hideAnimated:YES afterDelay:.5];
            }
        }];
    }

}

- (void)getAuthCode:(UIButton *)btn{
    NSString *phone = SelfVC.phoneTextField.textField.text;
    if (![phone isPhoneNumber]) {
        [MBProgressHUD showText:LocalizedString(@"请输入正确的手机号")];
        return;
    }
    btn.enabled = NO;
    [LoginAdapter getAuthCode:SelfVC.phoneTextField.textField.text completion:^(BOOL success, id response) {
        if (success) {
            [MBProgressHUD showText:@"发送验证码成功"];
            self.countDown = 60;
            [self startCountDown];
        }else{
            btn.enabled = YES;
        }
    }];
}

- (void)startCountDown{
    if (self.timer) {
        [self.timer resume];
    }else{
        self.timer = [YXYGCDTimer initWithSelector:@selector(countDownTimer) target:self timeInterval:1];
    }
}

- (void)countDownTimer{
    if (self.countDown <= 0) {
        [self.timer stop];
        [SelfVC.authCodeTextField.btnAuthCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        SelfVC.authCodeTextField.btnAuthCode.enabled = YES;
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%lds", --self.countDown];
    [SelfVC.authCodeTextField.btnAuthCode setTitle:str forState:UIControlStateNormal];
}

- (void)btnProtocolClicked{

}

- (void)wechatLoginClicked{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self.vc completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.gender);
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            self.openid = resp.openid;
            [self validateBindOpenid:resp.openid];
        }
    }];
}

- (void)validateBindOpenid:(NSString *)openid{
    [LoginAdapter WXJudgeBindPhoneByOpenid:openid completion:^(BOOL success, id response) {
        if (success) {
            if ([[response valueForKey:@"isSkipBindOpenid"] boolValue]) {
                SelfVC.type = Bind;
            }else{
                if ([response valueForKey:@"token"]) {
                    [UserDefaults setObject:[response valueForKey:@"token"] forKey:AccessToken];
                    [AccountManager refreshUserInfoWithParams:nil completion:^(UserModel * _Nonnull model) {
                        [RCIMManager loginIM];
                    }];
                }
                KEY_WINDOW.rootViewController = YXYTabBarController.new;
            }
        }
    }];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.text.length == 6 && ![string isEqualToString:@""]) {
        return NO;
    }
    if (textField.text.length == 5 && ![string isEqualToString:@""]) {
        SelfVC.btnLogin.backgroundColor = Color_Main;
        SelfVC.btnLogin.enabled = YES;
    }
    if (textField.text.length < 5 || (textField.text.length == 6 && [string isEqualToString:@""])) {
        SelfVC.btnLogin.backgroundColor = Color_C;
        SelfVC.btnLogin.enabled = NO;
    }
    return YES;
}
@end
