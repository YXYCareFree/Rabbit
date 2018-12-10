//
//  MoodDetailModel.m
//  YouTo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MoodDetailModel.h"

@implementation MoodDetailModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return  @{@"answerList": [AnswerListModel class]};
}
@end




/**
 心情
 */
@implementation AnswerListModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return  @{@"moodAnswerDetailList": [MoodAnswerDetailListModel class]};
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}

@end


@implementation MoodAnswerDetailListModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}

@end
