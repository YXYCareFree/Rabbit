//
//  AccountManager.h
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountManager : NSObject

/**
 当前账号的memberId

 @return <#return value description#>
 */
+ (NSString *)memberId;

+ (UserModel *)getUserInfo;

+ (void)refreshUserInfoWithParams:(NSDictionary *__nullable)params completion:(void(^__nullable)(UserModel *model))completion;

+ (void)addBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion;

+ (void)removeBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion;

+ (void)getBlackListPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

/**
 获取他人的动态（展示主页的时候调用）

 @param memberId <#memberId description#>
 @param completion <#completion description#>
 */
+ (void)getOtherUserInfoByMemberId:(NSString *)memberId pageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

+ (void)checkIsAttentionByMemeberId:(NSString *)memberId completion:(YXYCompletionBlock)completion;

+ (void)getRemarkName:(NSString *)memberId completion:(YXYCompletionBlock)completion;

+ (void)checkIsInBlackList:(NSString *)memberId completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
