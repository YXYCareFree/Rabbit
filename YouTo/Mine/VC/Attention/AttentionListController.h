//
//  AttentionListController.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"


typedef NS_ENUM(NSUInteger, AttentionListControllerType) {
    AttentionListControllerTypeAttentionMe,
    AttentionListControllerTypeEachOther,
    AttentionListControllerTypeAttentionOther,
};
NS_ASSUME_NONNULL_BEGIN

@interface AttentionListController : YouToViewController

@property (nonatomic, assign) AttentionListControllerType type;

@end

NS_ASSUME_NONNULL_END
