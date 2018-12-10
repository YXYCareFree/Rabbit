//
//  CityCommonInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "CityCommonController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityCommonInteractor : YXYBaseInteractor<SDCycleScrollViewDelegate>

@property (nonatomic, weak) CityCommonController *vc;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
