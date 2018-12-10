//
//  MatchInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "MatchController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchInteractor : YXYBaseInteractor

@property (nonatomic, weak) MatchController *vc;

- (void)btnUserClicked:(YXYButton *)btn;

- (void)btnGroupClicked:(YXYButton *)btn;

- (void)btnFilterClicked;

@end

NS_ASSUME_NONNULL_END
