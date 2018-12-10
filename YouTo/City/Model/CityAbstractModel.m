//
//  CityAbstractModel.m
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CityAbstractModel.h"

@implementation CityAbstractModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return  @{@"hotMember": [HotMemberModel class]};
}

@end




@implementation HotMemberModel

@end
