//
//  PublishInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PublishInteractor.h"
#import "YXYSelectPhoto.h"
#import "YXYSelectView.h"
#import "PublishAdapter.h"
#import "LocationManager.h"
#import "LoginAdapter.h"
#import "SelectCityView.h"
#import "YouToSelectPhoto.h"

@interface PublishInteractor ()

@property (nonatomic, strong) NSMutableArray *arrImgUrlStr;
@property (nonatomic, strong) NSString *adCode;
@property (nonatomic, strong) NSString *atCityAdCode;
@property (nonatomic, strong) NSString *moodSetting;

@end

@implementation PublishInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.atCityAdCode = GetAdcode;
    }
    return self;
}

- (void)addPhotoClicked{
    [YouToSelectPhoto selectPhoto:^(NSString * _Nonnull imgUrlStr) {
        [self.vc.photoView.dataSource addObject:imgUrlStr];
        self.vc.photoView.dataSource = self.vc.photoView.dataSource;
    }];
}

- (void)publishClicked{
    if (!self.atCityAdCode) {
        [YXYAlertView alertWithMessage:@"请选择@的城市" fromeVC:SelfVC];
        return;
    }
    if (![self validateParams]) {
        [MBProgressHUD showText:@"请先完善信息"];
        return;
    }
        
    NSString *infoImg = @"";
    if (SelfVC.photoView.dataSource.count) {
        infoImg = [SelfVC.photoView.dataSource componentsJoinedByString:@","];
    }
    if (self.vc.type == PublishControllerTypeHelp) {
        [PublishAdapter publishHelp:self.vc.textView.text infoImg:infoImg title:self.vc.titleTextField.text atCityAdcode:self.atCityAdCode?:@"" currentAddressAdcode:self.adCode?:@"" completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"发布成功"];
                [CurrentVC dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }else{
        [PublishAdapter publishMood:SelfVC.textView.text infoImg:infoImg visitType:self.moodSetting?:@"plazaShow" atCityAdcode:self.atCityAdCode?:@"" currentAddressAdcode:self.adCode?:@"" completion:^(BOOL success, id response) {
            if (success) {
                [MBProgressHUD showText:@"发布成功"];
                [CurrentVC dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}

- (void)getCurrentLocationClicked:(YXYButton *)btn{
    [LocationManager getCurrentLocation:^(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city) {
        btn.title([NSString stringWithFormat:@"   %@  ", city], UIControlStateNormal);
        self.adCode = adCode;
    }];
}

- (void)atCityClicked{
    [LoginAdapter getAreaCity:^(BOOL success, id response) {
        if (success) {
            [SelectCityView showSelectViewWithDataSource:response completion:^(NSString * _Nonnull city, NSString * _Nonnull code) {
                [SelfVC.btnAtCity setTitle:[NSString stringWithFormat:@"%@", city] forState:UIControlStateNormal];
                self.atCityAdCode = code;
            }];
        }
    }];
}

- (void)btnSettingClicked:(YXYButton *)btn{
    NSArray *arr = @[@"plazaShow", @"onlyMyself", @"homeShow"];
    [YXYSelectView initWithDataSource:@[@"广场可见", @"仅自己可见", @"仅主页可见"] confirmBtnColor:Color_Main cancelBtnColor:Color_Main completion:^(NSString *str, NSInteger idx) {
        [btn setTitle:[NSString stringWithFormat:@"  %@   ", str] forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width - 5, 0, 0);
        });
        self.moodSetting = arr[idx];
    }];
}

- (BOOL)validateParams{
    if (!SelfVC.textView.text.length) return NO;
    
    if (SelfVC.type == PublishControllerTypeHelp) {
        if (!SelfVC.titleTextField.text.length) return NO;
    }
    return YES;
}
#pragma mark--UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    SelfVC.lblPlaceHolder.hidden = textView.text.length + text.length;
    if (textView.text.length == 1 && [text isEqualToString:@""]) {
        SelfVC.lblPlaceHolder.hidden = NO;
    }
    if (SelfVC.lblPlaceHolder.hidden) {
        SelfVC.btnPublish.enabled = YES;
        SelfVC.btnPublish.color(WhiteColor, UIControlStateNormal);
        SelfVC.btnPublish.backgroundColor = Color_Main;
    }else{
        SelfVC.btnPublish.enabled = NO;
        SelfVC.btnPublish.color(ColorWithHex(@"999999"), UIControlStateNormal);
        SelfVC.btnPublish.backgroundColor = Color_E;
    }
    return YES;
}

- (NSMutableArray *)arrImgUrlStr{
    if (!_arrImgUrlStr) {
        _arrImgUrlStr = NSMutableArray.new;
    }
    return _arrImgUrlStr;
}
@end
