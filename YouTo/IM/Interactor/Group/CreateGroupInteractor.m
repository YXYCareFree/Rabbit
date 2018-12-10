//
//  CreateGroupInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CreateGroupInteractor.h"
#import "YouToSelectPhoto.h"
#import "UIButton+WebCache.h"
#import "SelectCityView.h"
#import "LoginAdapter.h"
#import "GroupTypeController.h"

@interface CreateGroupInteractor ()

@property (nonatomic, strong) NSString *imgUrlStr;
@property (nonatomic, strong) NSString *cityCode;

@end

@implementation CreateGroupInteractor

- (void)btnPhotoClicked{
    [YouToSelectPhoto selectPhoto:^(NSString * _Nonnull imgUrlStr) {
        self.imgUrlStr = imgUrlStr;
        [SelfVC.btnPhoto sd_setImageWithURL:URLWithStr(imgUrlStr) forState:UIControlStateNormal placeholderImage:SelfVC.btnPhoto.currentImage];
    }];
}

- (void)nextClicked{
    if (![self validateParams]) return;
    
    GroupTypeController *vc = [[GroupTypeController alloc] init];
    vc.imgUrlStr = self.imgUrlStr;
    vc.groupIntroduce = SelfVC.txtVIntroduce.text;
    vc.groupName = SelfVC.txtFNickName.text;
    vc.cityCode = self.cityCode;
    PushVC(vc);
}

- (BOOL)validateParams{
    if (!self.imgUrlStr) {
        [MBProgressHUD showText:@"请设置群头像"];
        return NO;
    }
    if (!SelfVC.txtFNickName.text.length) {
        [MBProgressHUD showText:@"请设置群昵称"];
        return NO;
    }
    if (!SelfVC.txtVIntroduce.text.length) {
        [MBProgressHUD showText:@"请设置群介绍"];
        return NO;
    }
    if (!SelfVC.txtFCity.text.length) {
        [MBProgressHUD showText:@"请设置城市"];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == SelfVC.txtFCity) {
        [LoginAdapter getAreaCity:^(BOOL success, id response) {
            if (success) {
                [SelectCityView showSelectViewWithDataSource:response completion:^(NSString * _Nonnull city, NSString * _Nonnull code) {
                    self.cityCode = code;
                    textField.text = city;
                }];
            }
        }];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == SelfVC.txtFNickName) {
        if ((textField.text.length + string.length) > 20) {
            [MBProgressHUD showText:@"昵称不能超过20字符"];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    SelfVC.lblIntroduce.hidden = textView.text.length + text.length;
    if ((textView.text.length + text.length > 120)) {
        [MBProgressHUD showText:@"群介绍最多不能超过120字"];
        return NO;
    }
    return YES;
}

@end
