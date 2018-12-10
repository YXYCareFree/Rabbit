//
//  SelectCityModel.h
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCityModel : NSObject

@property (nonatomic, strong) NSString *adcode;
@property (nonatomic, strong) NSString *cityName;

@end



@interface HotCityModel : NSObject

@property (nonatomic, strong) NSString *adcode;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *headImg;

@end
NS_ASSUME_NONNULL_END
