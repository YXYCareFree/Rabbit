//
//  CityCommonController.h
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityCommonController : YouToViewController

@property (nonatomic, assign) CityContentType type;
@property (nonatomic, strong) SDCycleScrollView *bannerView;


- (void)loadData;

@end

NS_ASSUME_NONNULL_END
