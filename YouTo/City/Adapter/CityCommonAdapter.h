//
//  CityCommonAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityCommonAdapter : NSObject

+ (void)getCityAbstract:(YXYCompletionBlock)completion;

+ (void)getCityHelpDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

+ (void)getCitySquareDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

+ (void)getCityNewsDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

+ (void)getCityStrategyDataPageNum:(NSString *)pageNum completion:(YXYCompletionBlock)completion;

+ (void)likeWiehMoodID:(NSString *)moodID completion:(YXYCompletionBlock)completion;

+ (void)unlikeWiehMoodID:(NSString *)moodID completion:(YXYCompletionBlock)completion;

+ (void)getWarmHeartList:(NSString *)pageNum adcode:(NSString *)adcode completion:(YXYCompletionBlock)completion;

+ (void)attention:(NSString *)memberID completion:(YXYCompletionBlock)completion;

+ (void)unattention:(NSString *)memberID completion:(YXYCompletionBlock)completion;

+ (void)likeCity:(YXYCompletionBlock)completion;

+ (void)unlikeCity:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
