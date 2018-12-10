//
//  FillLocationInteractor.m
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FillLocationInteractor.h"
#import "SelectCityView.h"
#import "LocationManager.h"
#import "LoginAdapter.h"
#import "AccountManager.h"
#import "YXYTabBarController.h"

@interface FillLocationInteractor ()

@property (nonatomic, strong) NSArray *arrArea;
@property (nonatomic, strong) NSMutableDictionary *mdic;
@property (nonatomic, strong) NSMutableArray *marrAgoCityName;
@property (nonatomic, strong) NSMutableArray *marrAgoCityCode;
@property (nonatomic, strong) NSMutableArray *marrFutureCityName;
@property (nonatomic, strong) NSMutableArray *marrFutureCityCode;

@end

@implementation FillLocationInteractor

- (void)getCurrentLocation{
    [LocationManager getCurrentLocation:^(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city) {
        NSLog(@"%@, %@, %@, %@", latitude, longitude, cityCode, city);
        if (city) {
            SelfVC.addressTextF.text = city;
        }else{
            [MBProgressHUD showText:@"获取定位失败"];
        }
    }];
}

- (void)addDidCityClicked{
    if (self.marrAgoCityCode.count >= 6) {
        [MBProgressHUD showText:@"最多可选6个城市"];
        return;
    }
    [self selectCity:^(NSString *city, NSString *code) {
        if ([self.marrAgoCityName containsObject:city]) {
            return ;
        }
        [self.marrAgoCityName addObject:city];
        [self.marrAgoCityCode addObject:code];
        SelfVC.vDid.dataSource = self.marrAgoCityName;
    }];
}

- (void (^)(NSString * _Nonnull))RemoveFuture{
    WEAKSELF;
    return ^(NSString *city){
        NSInteger idx = [weakSelf.marrFutureCityName indexOfObject:city];
        [weakSelf.marrFutureCityCode removeObjectAtIndex:idx];
        [weakSelf.marrFutureCityName removeObjectAtIndex:idx];
        weakSelf.vc.vFuture.dataSource = self.marrFutureCityName;
    };
}

- (void (^)(NSString * _Nonnull))RemoveAgo{
    WEAKSELF;
    return ^(NSString *city){
        NSInteger idx = [weakSelf.marrAgoCityName indexOfObject:city];
        [weakSelf.marrAgoCityCode removeObjectAtIndex:idx];
        [weakSelf.marrAgoCityName removeObjectAtIndex:idx];
        weakSelf.vc.vDid.dataSource = self.marrAgoCityName;
    };
}

- (void)addFutureCityClicked{
    if (self.marrFutureCityName.count >= 6) {
        [MBProgressHUD showText:@"最多可选6个城市"];
        return;
    }
    [self selectCity:^(NSString *city, NSString *code) {
        if ([self.marrFutureCityName containsObject:city]) return ;
        [self.marrFutureCityCode addObject:code];
        [self.marrFutureCityName addObject:city];
        SelfVC.vFuture.dataSource = self.marrFutureCityName;
    }];
}

- (void)btnFinishClicked{

    if (self.marrFutureCityName.count) {
        NSString *name = [self.marrFutureCityName componentsJoinedByString:@"、"];
        NSString *code = [self.marrFutureCityCode componentsJoinedByString:@"、"];
        [self.mdic setObject:name forKey:@"futureGoCityName"];
        [self.mdic setObject:code forKey:@"futureGoCityId"];
    }else{
        [self.mdic setObject:@"" forKey:@"futureGoCityName"];
        [self.mdic setObject:@"" forKey:@"futureGoCityId"];
    }
    
    if (self.marrAgoCityCode.count) {
        NSString *name = [self.marrAgoCityName componentsJoinedByString:@"、"];
        NSString *code = [self.marrAgoCityCode componentsJoinedByString:@"、"];
        [self.mdic setObject:name forKey:@"agoGoCityName"];
        [self.mdic setObject:code forKey:@"agoGoCityId"];
    }else{
        [self.mdic setObject:@"" forKey:@"agoGoCityName"];
        [self.mdic setObject:@"" forKey:@"agoGoCityId"];
    }
    
    if (self.mdic.allKeys.count) {
        [AccountManager refreshUserInfoWithParams:self.mdic completion:^(UserModel * _Nonnull model) {
            if (SelfVC.type == FillLocationControllerTypeLogin) {
                KEY_WINDOW.rootViewController = [YXYTabBarController new];
            }else{
                [SelfVC.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)selectCity:(void(^)(NSString *city, NSString *code))completion{
    if (self.arrArea) {
        [SelectCityView showSelectViewWithDataSource:self.arrArea completion:^(NSString * _Nonnull city, NSString * _Nonnull code) {
            NSLog(@"%@, %@", city, code);
            [self.mdic setObject:@NO forKey:@"isPosition"];
            if (completion) {
                completion(city, code);
            }
        }];
    }else{
        [LoginAdapter getAreaCity:^(BOOL success, id response) {
            if (success) {
                self.arrArea = response;
                [SelectCityView showSelectViewWithDataSource:self.arrArea completion:^(NSString * _Nonnull city, NSString * _Nonnull code) {
                    NSLog(@"%@, %@", city, code);
                    [self.mdic setObject:@NO forKey:@"isPosition"];
                    if (completion) {
                        completion(city, code);
                    }
                }];
            }
        }];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self selectCity:^(NSString *city, NSString *code) {
        textField.text = city;
        if (textField == SelfVC.addressTextF) {
            [self.mdic setObject:code forKey:@"currentLiveAddressId"];
        }else{
            [self.mdic setObject:code forKey:@"birthAddressId"];
        }
    }];

    return NO;
}

- (NSMutableDictionary *)mdic{
    if (!_mdic) {
        _mdic = NSMutableDictionary.new;
    }
    return _mdic;
}

- (NSMutableArray *)marrAgoCityCode{
    if (!_marrAgoCityCode) {
        UserModel *model = [AccountManager getUserInfo];
        _marrAgoCityCode = [NSMutableArray arrayWithArray:[model.agoGoCityId componentsSeparatedByString:@"、"]];
        [_marrAgoCityCode removeObject:@""];
    }
    return _marrAgoCityCode;
}

- (NSMutableArray *)marrAgoCityName{
    if (!_marrAgoCityName) {
        _marrAgoCityName = SelfVC.vDid.dataSource;
        UserModel *model = [AccountManager getUserInfo];
        _marrAgoCityName = [NSMutableArray arrayWithArray:[model.agoGoCityName componentsSeparatedByString:@"、"]];
        [_marrAgoCityName removeObject:@""];
    }
    return _marrAgoCityName;
}

- (NSMutableArray *)marrFutureCityName{
    if (!_marrFutureCityName) {
        _marrFutureCityName = SelfVC.vFuture.dataSource;
        UserModel *model = [AccountManager getUserInfo];
        _marrFutureCityName = [NSMutableArray arrayWithArray:[model.futureGoCityName componentsSeparatedByString:@"、"]];
        [_marrFutureCityName removeObject:@""];
    }
    return _marrFutureCityName;
}

- (NSMutableArray *)marrFutureCityCode{
    if (!_marrFutureCityCode) {
        UserModel *model = [AccountManager getUserInfo];
        _marrFutureCityCode = [NSMutableArray arrayWithArray:[model.futureGoCityId componentsSeparatedByString:@"、"]];
        [_marrFutureCityCode removeObject:@""];
    }
    return _marrFutureCityCode;
}
@end
