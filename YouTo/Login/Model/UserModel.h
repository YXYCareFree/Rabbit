//
//  UserModel.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoodDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic, strong) NSArray<MoodDetailModel*> *dataList;

/**
 曾经去过的城市行政编码 用,拼接
 */
@property (nonatomic, strong) NSString *agoGoCityId;

/**
 曾经去过的城市名称
 */
@property (nonatomic, strong) NSString *agoGoCityName;

/**
 出生地
 */
@property (nonatomic, strong) NSString *birthAddress;

/**
 现居地
 */
@property (nonatomic, strong) NSString *currentLiveAddress;

/**
 出生年月
 */
@property (nonatomic, strong) NSString *dateOfBirth;

/**
 未来想去的城市行政编码
 */
@property (nonatomic, strong) NSString *futureGoCityId;

/**
 未来想去的城市名称
 */
@property (nonatomic, strong) NSString *futureGoCityName;

@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *memberId;

@property (nonatomic, strong) NSString *personalizedSignature;//签名

@property (nonatomic, strong) NSString *matchValue;
@property (nonatomic, strong) NSString *IMSig;

@property (nonatomic, assign) BOOL isConcern;

@property (nonatomic, strong) NSString *levelNextLevel;
@property (nonatomic, strong) NSString *levelName;//幼儿兔🐇
@property (nonatomic, strong) NSString *levelName2;//V1
@property (nonatomic, strong) NSString *levelScore;//当前的分数



+ (void)saveUserInfo:(id)userInfo;

+ (void)clearUserInfo;

+ (UserModel *)getUserModel;

@end

NS_ASSUME_NONNULL_END
