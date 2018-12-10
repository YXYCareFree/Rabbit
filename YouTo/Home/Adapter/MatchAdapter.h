//
//  MatchAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchAdapter : NSObject

+ (void)matchUserPageNum:(NSString *)pageNum filterProperty:(NSString *)filterProperty orderProperty:(NSString *)orderProperty completion:(YXYCompletionBlock)completion;

+ (void)matchUserWithFilter:(NSString *)filter completion:(YXYCompletionBlock)completion;

+ (void)matchGroupPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
