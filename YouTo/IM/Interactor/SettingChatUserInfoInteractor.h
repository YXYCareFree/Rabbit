//
//  SettingChatUserInfoInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "SettingChatUserInfoController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingChatUserInfoInteractor : YXYBaseInteractor

@property (nonatomic, weak) SettingChatUserInfoController *vc;

- (void)loadData;

- (void)getRemarkName:(void(^)(NSString *remarkName))block;

@end

NS_ASSUME_NONNULL_END
