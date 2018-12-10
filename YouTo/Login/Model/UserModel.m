//
//  UserModel.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserModel.h"
#import "YYCache.h"
#import "NSObject+YYModel.h"

@implementation UserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"memberId": @[@"memberId", @"id"]};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return  @{@"dataList": [MoodDetailModel class]};
}


+ (void)saveUserInfo:(id)userInfo{
    YYCache *cache = [YYCache cacheWithName:@"UserInfo"];
    [cache setObject:userInfo forKey:@"UserInfo"];
}

+ (void)clearUserInfo{
    YYCache *cache = [YYCache cacheWithName:@"UserInfo"];
    [cache removeObjectForKey:@"UserInfo"];
    [UserDefaults removeObjectForKey:AccessToken];
}

+ (UserModel *)getUserModel{
    YYCache *cache = [YYCache cacheWithName:@"UserInfo"];
    id userInfo = [cache objectForKey:@"UserInfo"];
    return [UserModel yy_modelWithJSON:userInfo];
}
@end
