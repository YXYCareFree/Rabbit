//
//  SearchCityModel.h
//  YouTo
//
//  Created by apple on 2018/12/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCityModel : NSObject

@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *showInfo;
@property (nonatomic, strong) NSString *showImg;
@property (nonatomic, strong) NSString *showHeadImg;
@property (nonatomic, strong) NSString *adCode;

@end


@interface HotCityModel : NSObject

@property (nonatomic, strong) NSString *adcode;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *headImg;

@end

NS_ASSUME_NONNULL_END
