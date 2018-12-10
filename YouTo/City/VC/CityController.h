//
//  CityController.h
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YPTabBarController.h"

@interface CityController : YPTabBarController

- (instancetype)initWithType:(CityContentType)type;

@property (nonatomic, assign) CityContentType type;

@property (nonatomic, copy) void(^ChangeCityContentBlock)(CityContentType type);

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
