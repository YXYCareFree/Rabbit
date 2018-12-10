//
//  PublishAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishAdapter : NSObject

+ (void)publishMood:(NSString *)info infoImg:(NSString *)infoImg visitType:(NSString *)visitType atCityAdcode:(NSString *)cityAdcode currentAddressAdcode:(NSString *)currentAddressAdcode completion:(YXYCompletionBlock)completion;

+ (void)publishHelp:(NSString *)info infoImg:(NSString *)infoImg title:(NSString *)title atCityAdcode:(NSString *)cityAdcode currentAddressAdcode:(NSString *)currentAddressAdcode completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
