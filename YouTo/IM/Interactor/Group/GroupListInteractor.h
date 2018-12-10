//
//  GroupListInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "GroupListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupListInteractor : YXYBaseInteractor

- (void)loadData;

@property (nonatomic, weak) GroupListController *vc;

@end

NS_ASSUME_NONNULL_END
