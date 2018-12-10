//
//  LocationManager.h
//
//  Created by apple on 2018/9/10.
//  Copyright © 2018年 Yutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+ (instancetype)shareLocationManager;

+ (void)getCurrentLocation:(void(^)(NSString *latitude, NSString *longitude, NSString *adCode, NSString *cityCode, NSString *city))completion;

/**
 获取定位的cityCode

 @param block 回调
 */
+ (void)getCityCodeByCityName:(NSString *)cityName completion:(void(^)(NSString *cityCode))block;

@end
