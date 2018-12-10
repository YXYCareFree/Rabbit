//
//  MatchUserModel.m
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MatchUserModel.h"

@implementation MatchUserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"memberId": @[@"memberId", @"id"]};
}

@end
