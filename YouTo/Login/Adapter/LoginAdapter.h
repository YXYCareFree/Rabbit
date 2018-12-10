//
//  LoginAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginAdapter : NSObject

+ (void)loginWithPhone:(NSString *)phone authCode:(NSString *)code completion:(YXYCompletionBlock)completion;

+ (void)loginByWXOpenid:(NSString *)openid phone:(NSString *)phone authCode:(NSString *)code completion:(YXYCompletionBlock)completion;

+ (void)autoLoginByToken:(YXYCompletionBlock)completion;

+ (void)getAuthCode:(NSString *)phone completion:(YXYCompletionBlock)completion;

+ (void)sendDeviceToken:(NSString *)deviceToken completion:(YXYCompletionBlock)completion;

+ (void)WXJudgeBindPhoneByOpenid:(NSString *)openid completion:(YXYCompletionBlock)completion;

+ (void)getUserInfo:(YXYCompletionBlock)completion;

+ (void)uploadLocation:(YXYCompletionBlock)completion;

+ (void)updateUserInfo:(NSDictionary *)params completion:(YXYCompletionBlock)completion;

+ (void)getAreaCity:(YXYCompletionBlock)completion;

+ (void)getRCToken:(YXYCompletionBlock)completion;

+ (void)getUserInfoByMemberId:(NSString *)memberId completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
