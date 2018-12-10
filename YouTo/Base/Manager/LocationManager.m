//
//  LocationManager.m
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import "LocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "YXYAlertView.h"

@interface LocationManager ()<AMapSearchDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, copy) void (^GetCityCodeBlcok)(NSString *cityCode);

@end

@implementation LocationManager

+ (instancetype)shareLocationManager{
    static LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LocationManager new];
    });
    return manager;
}

+ (void)getCurrentLocation:(void (^)(NSString *, NSString *, NSString *, NSString * , NSString *))completion{
    if (![LocationManager getAuthorityStatus]) {
        return;
    }
    LocationManager *manager = [LocationManager shareLocationManager];
    manager.locationManager = [[AMapLocationManager alloc] init];
    [manager.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    manager.locationManager.locationTimeout =2;
    manager.locationManager.reGeocodeTimeout = 2;
    //   定位超时时间，最低2s，此处设置为10s
    manager.locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    manager.locationManager.reGeocodeTimeout = 10;
    [manager.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        NSString *latitude;NSString *longitude;NSString *cityCode;NSString *city; NSString *adCode;
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
            }
            if (completion) {
                completion(latitude, longitude, adCode, cityCode, city);
            }
            return;
        }
        if (location) {
            CLLocationDegrees lat = location.coordinate.latitude;
            CLLocationDegrees lon = location.coordinate.longitude;
            latitude = [NSString stringWithFormat:@"%f",lat];
            longitude = [NSString stringWithFormat:@"%f",lon];
        }
        if (regeocode){
            NSLog(@"reGeocode:%@", regeocode);
            cityCode = regeocode.citycode;
            city = regeocode.city;
            adCode = regeocode.adcode;
        }
        [UserDefaults setObject:adCode?:@"" forKey:Adcode];
        [UserDefaults synchronize];
        if (completion) {
            completion(latitude, longitude, adCode, cityCode, city);
        }
    }];
}

+ (void)getCityCodeByCityName:(NSString *)cityName completion:(void (^)(NSString *))block{
    LocationManager *location = [LocationManager shareLocationManager];
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = cityName;
    [location.search AMapGeocodeSearch:geo];
    location.GetCityCodeBlcok = block;
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    NSArray *array = response.geocodes;
    AMapGeocode *geocode = array.firstObject;
    [LocationManager shareLocationManager].GetCityCodeBlcok(geocode.citycode?:@"");
}

+ (BOOL)getAuthorityStatus{
    if (![CLLocationManager locationServicesEnabled]) {
        [YXYAlertView alertWithTitle:@"提示" message:@"请去设置里打开定位" confirmTitle:@"去打开" cancelTitle:@"取消" fromeVC:CurrentVC completion:^(BOOL isConfirm) {
            if (isConfirm) {
                
            }
        }];
        return NO;
    }
//    status == kCLAuthorizationStatusNotDetermined ||
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        [YXYAlertView alertWithTitle:@"提示" message:@"请去设置里允许游兔使用您的位置信息" confirmTitle:@"去打开" cancelTitle:@"取消" fromeVC:CurrentVC completion:^(BOOL isConfirm) {
            if (isConfirm) {
                
            }
        }];
    }

    return YES;
}

- (AMapSearchAPI *)search{
    if (!_search) {
        _search = [AMapSearchAPI new];
        _search.delegate = self;
    }
    return _search;
}
@end
