//
//  ApplyJoinGroupController.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

typedef NS_ENUM(NSUInteger, ApplyJoinGroupControllerType) {
    ApplyJoinGroupControllerTypeApply,
    ApplyJoinGroupControllerTypeFeedback,
    ApplyJoinGroupControllerTypeSign,
    ApplyJoinGroupControllerTypeNickName,
    ApplyJoinGroupControllerTypeRefuse,
    ApplyJoinGroupControllerTypeGroupNickName,
};
NS_ASSUME_NONNULL_BEGIN

@interface ApplyJoinGroupController : YouToViewController

@property (nonatomic, assign) ApplyJoinGroupControllerType type;

@property (nonatomic, copy) void(^BtnClickedBlock)(NSString *str);

/**
 设置备注人的memberId
 */
@property (nonatomic, strong) NSString *remarkId;

/**
 要加入群的ID
 */
@property (nonatomic, strong) NSString *groupId;

@end

NS_ASSUME_NONNULL_END
