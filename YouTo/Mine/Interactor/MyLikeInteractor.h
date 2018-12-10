//
//  MyLikeInteractor.h
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "MyLikeController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyLikeInteractor : YXYBaseInteractor

@property (nonatomic, weak) MyLikeController *vc;

- (void)loadData;


@end

NS_ASSUME_NONNULL_END
