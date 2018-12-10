//
//  UserInfoInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "UserInfoController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoInteractor : YXYBaseInteractor

@property (nonatomic, weak) UserInfoController *vc;

- (void)loadData;

- (void)atttionClicked;

- (void)chatClicked;

@end

NS_ASSUME_NONNULL_END
