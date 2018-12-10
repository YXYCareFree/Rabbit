//
//  GroupInfoModel.m
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GroupInfoModel.h"

@implementation GroupInfoModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"faceUrl": @[@"face_url", @"faceUrl"]};
}

@end
