//
//  NotifiController.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

typedef NS_ENUM(NSUInteger, NotifiControllerType) {
    NotifiControllerTypeAll,
    NotifiControllerTypeGroup,
    NotifiControllerTypeDynamic,
    NotifiControllerTypeOfficial,
};
NS_ASSUME_NONNULL_BEGIN

@interface NotifiController : YouToViewController

@property (nonatomic, assign) NotifiControllerType type;

@end

NS_ASSUME_NONNULL_END
