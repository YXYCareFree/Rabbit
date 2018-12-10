//
//  AttentionListInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "AttentionListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttentionListInteractor : YXYBaseInteractor

- (void)loadData;

@property (nonatomic, weak) AttentionListController *vc;

@end

NS_ASSUME_NONNULL_END
