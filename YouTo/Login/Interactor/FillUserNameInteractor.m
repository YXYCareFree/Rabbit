//
//  FillUserNameInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FillUserNameInteractor.h"
#import "YXYSelectBirthdaySheet.h"
#import "YXYSelectView.h"
#import "UploadAliManager.h"
#import "LoginAdapter.h"
#import "FillLocationController.h"
#import "YouToSelectPhoto.h"
#import "UIButton+WebCache.h"
#import "AccountManager.h"

@interface FillUserNameInteractor ()

@property (nonatomic, strong) UIImage *selectedUserIconImage;
@property (nonatomic, strong) NSMutableDictionary *mdicUserInfo;

@end

@implementation FillUserNameInteractor

- (void)selectUserIconClicked:(UIButton *)btn{
    [YouToSelectPhoto selectPhoto:^(NSString * _Nonnull imgUrlStr) {
        [self.mdicUserInfo setObject:imgUrlStr forKey:@"headImg"];
        [self.vc.btnUserIcon sd_setImageWithURL:URLWithStr(imgUrlStr) forState:UIControlStateNormal];
    }];
}

- (void)selectSexClicked{
    [YXYSelectView initWithDataSource:@[@"男", @"女"] confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
        self.vc.sexTextF.text = str;
        if ([str isEqualToString:@"男"]) {
            [self.mdicUserInfo setObject:@"boy" forKey:@"sex"];
        }else{
            [self.mdicUserInfo setObject:@"girl" forKey:@"sex"];
        }
    }];
}

- (void)nextStep{
    if (![self validateParams]) return;
    [AccountManager refreshUserInfoWithParams:self.mdicUserInfo completion:^(UserModel * _Nonnull model) {
        FillLocationController *vc = [[FillLocationController alloc] init];
        vc.type = FillLocationControllerTypeLogin;
        PushVC(vc);
    }];
}

- (BOOL)validateParams{
    if (SelfVC.nickTextF.text.length == 0) {
        [MBProgressHUD showText:@"请设置昵称，让大家更好的了解你"];
        return NO;
    }
    [self.mdicUserInfo setObject:SelfVC.nickTextF.text forKey:@"nickName"];
    if (![self.mdicUserInfo objectForKey:@"headImg"]) {
        [MBProgressHUD showText:@"请设置头像，让大家更好的了解你"];
        return NO;
    }
    if (![self.mdicUserInfo objectForKey:@"sex"]) {
        [MBProgressHUD showText:@"请选择性别"];
        return NO;
    }
    if (![self.mdicUserInfo objectForKey:@"dateOfBirth"]) {
        [MBProgressHUD showText:@"请选择出生年月"];
        return NO;
    }

    return YES;
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.vc.birthdayTextF) {
        [YXYSelectBirthdaySheet initWithSelectedBirthdayConfirmColor:Color_Main cancelColor:Color_Main completion:^(NSString *birthday) {
            self.vc.birthdayTextF.text = birthday;
            [self.mdicUserInfo setObject:birthday forKey:@"dateOfBirth"];
        }];
    }
    if (textField == self.vc.sexTextF) {
        [self selectSexClicked];
    }
    return NO;
}

- (NSMutableDictionary *)mdicUserInfo{
    if (!_mdicUserInfo) {
        _mdicUserInfo = [NSMutableDictionary new];
    }
    return _mdicUserInfo;
}
@end
