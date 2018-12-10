//
//  MessageListAdapter.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageListAdapter : NSObject

+ (void)getGroupList:(YXYCompletionBlock)completion;

+ (void)getC2CList:(YXYCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
