//
//  NotifiAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifiAdapter : NSObject

+ (void)getAllNotifi:(YXYCompletionBlock)completion;

+ (void)getAllNotifiByType:(NSString *)type completion:(YXYCompletionBlock)completion;

+ (void)getJoinGroupDetail:(NSString *)sourceId completion:(YXYCompletionBlock)completion;

+ (void)checkJoinGroup:(NSString *)joinGroupInfoId status:(BOOL)status refuse:(NSString *_Nullable)reason completion:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
