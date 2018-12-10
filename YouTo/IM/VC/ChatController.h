//
//  ChatController.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

typedef NS_ENUM(NSUInteger, ChatControllerType) {
    ChatControllerTypeC2C,
    ChatControllerTypeGroup,
};
NS_ASSUME_NONNULL_BEGIN

@interface ChatController : RCConversationViewController

//@property (nonatomic, assign) ChatControllerType type;

@end

NS_ASSUME_NONNULL_END
