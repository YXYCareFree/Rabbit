//
//  NotifiInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "NotifiController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotifiInteractor : YXYBaseInteractor

@property (nonatomic, weak) NotifiController *vc;


- (void)loadData;

@end

NS_ASSUME_NONNULL_END
