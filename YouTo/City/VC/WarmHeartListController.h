//
//  WarmHeartListController.h
//  YouTo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

typedef NS_ENUM(NSUInteger, WarmHeartListControllerType) {
    WarmHeartListControllerTypeAllCountry,
    WarmHeartListControllerTypeCity,
    WarmHeartListControllerTypeForegin,
};
NS_ASSUME_NONNULL_BEGIN

@interface WarmHeartListController : YouToViewController

@property (nonatomic, assign) WarmHeartListControllerType type;

@end

NS_ASSUME_NONNULL_END
