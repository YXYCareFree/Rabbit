//
//  SettingChatUserInfoController.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface SettingChatUserInfoController : YouToViewController

- (instancetype)initWithMemberId:(NSString *)memberId remarkName:(NSString *)remarkName;

@property (nonatomic, strong) NSString *memberId;

@end

NS_ASSUME_NONNULL_END
