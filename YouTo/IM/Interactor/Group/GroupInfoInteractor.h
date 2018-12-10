//
//  GroupInfoInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "GroupInfoController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupInfoInteractor : YXYBaseInteractor<SDCycleScrollViewDelegate>

@property (nonatomic, weak) GroupInfoController *vc;

@property (nonatomic, strong) NSArray *groupMemberData;

- (void)loadData;

- (void)btnJoinClicked;

@end

NS_ASSUME_NONNULL_END
