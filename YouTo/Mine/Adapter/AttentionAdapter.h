//
//  AttentionAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttentionAdapter : NSObject

+ (void)getAttentionMePageNum:(NSString*)pageNum completion:(YXYCompletionBlock)completion;

+ (void)getAttentionEachOtherPageNum:(NSString*)pageNum completion:(YXYCompletionBlock)completion;

+ (void)getMyAttentionPageNum:(NSString*)pageNum completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
