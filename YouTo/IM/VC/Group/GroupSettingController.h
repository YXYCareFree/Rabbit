//
//  GroupSettingController.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupSettingController : YouToViewController

@property (nonatomic, strong) NSString *groupId;

@property (nonatomic, assign) BOOL isGroupOwner;//是否是群主

@end

NS_ASSUME_NONNULL_END
