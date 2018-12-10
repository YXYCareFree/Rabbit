//
//  CommonDetailAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface CommonDetailAdapter : NSObject

- (void)getDetailInfo:(NSString *)ID completion:(YXYCompletionBlock)completion;

/**
 添加回复

 @param info <#info description#>
 @param infoId <#infoId description#>
 @param completion <#completion description#>
 */
- (void)addReplyInfo:(NSString *)info infoId:(NSString *)infoId completion:(YXYCompletionBlock)completion;

/**
 添加回复的回复

 @param info <#info description#>
 @param infoId <#infoId description#>
 @param mentionId <#infoId description#>
 @param completion <#completion description#>
 */
- (void)addAnswerInfo:(NSString *)info infoId:(NSString *)infoId mentionId:(NSString *_Nullable)mentionId completion:(YXYCompletionBlock)completion;

/**
 点赞评论

 @param replyId <#replyId description#>
 @param completion <#completion description#>
 */
- (void)likeReplyId:(NSString *)replyId completion:(YXYCompletionBlock)completion;

/**
 点赞评论的评论
 
 @param answerId <#replyId description#>
 @param completion <#completion description#>
 */
- (void)likeAnswerId:(NSString *)answerId completion:(YXYCompletionBlock)completion;

/**
 取消点赞评论
 
 @param replyId <#replyId description#>
 @param completion <#completion description#>
 */
- (void)unlikeReplyId:(NSString *)replyId completion:(YXYCompletionBlock)completion;

/**
 取消点赞评论的评论
 
 @param answerId <#replyId description#>
 @param completion <#completion description#>
 */
- (void)unlikeAnswerId:(NSString *)answerId completion:(YXYCompletionBlock)completion;

/**
 删除评论

 @param replyId 评论的ID
 @param msgId 被评论消息的ID
 @param completion <#completion description#>
 */
- (void)deleteReplyId:(NSString *)replyId msgId:(NSString *)msgId completion:(YXYCompletionBlock)completion;

/**
 查看更多的回复

 @param replyId <#replyId description#>
 @param pageNum <#pageNum description#>
 @param completion <#completion description#>
 */
- (void)findMoreReply:(NSString *)replyId pageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

/**
 设置精选回答（求助版块）

 @param choiceId <#choiceId description#>
 @param completion <#completion description#>
 */
- (void)setGoodChoice:(NSString *)choiceId completion:(YXYCompletionBlock)completion;

- (void)addAttentionMemberId:(NSString *)focusedMemberId completion:(YXYCompletionBlock)completion;

- (void)cancelAttentionMemberId:(NSString *)focusedMemberId completion:(YXYCompletionBlock)completion;

#pragma mark--Mood心情
- (void)updateMoodVist:(NSString *)moodId visitType:(NSString *)visitType completion:(YXYCompletionBlock)completion;

- (void)deleteMood:(NSString *)moodId completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
