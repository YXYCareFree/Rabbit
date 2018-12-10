//
//  GroupAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupAdapter : NSObject

+ (void)getGroupInfo:(NSString *)groupId completion:(YXYCompletionBlock)completion;

+ (void)getMemberInfo:(NSString *)memberId inGroupId:(NSString *)groupId completion:(YXYCompletionBlock)completion;

+ (void)deleteGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion;

+ (void)exitGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion;

+ (void)getGroupMemberList:(NSString *)groupId completion:(YXYCompletionBlock)completion;

+ (void)applyJoinGroup:(NSString *)groupId applyReason:(NSString *)reason completion:(YXYCompletionBlock)completion;

+ (void)deleteMember:(NSString *)memberId inGroup:(NSString *)groupId completion:(YXYCompletionBlock)completion;


/**
 设置群名片
 */
+ (void)setGroupRemarkName:(NSString *)name groupId:(NSString *)groupId completion:(YXYCompletionBlock)completion;

/**
 获取群名片

 @param groupId <#groupId description#>
 @param memberId <#memberId description#>
 @param completion <#completion description#>
 */
+ (void)getRemarkNameInGroup:(NSString *)groupId memberId:(NSString *)memberId completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
