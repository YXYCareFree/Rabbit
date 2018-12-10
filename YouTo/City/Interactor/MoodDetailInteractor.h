//
//  MoodDetailInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
#import "MoodDetailController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoodDetailInteractor : YXYBaseInteractor<InputFieldDelegate>

@property (nonatomic, weak) MoodDetailController *vc;

- (void)loadData;

- (void)btnSettingClicked;

- (void)atttionClicked;

- (void)chatClicked;

@end

NS_ASSUME_NONNULL_END
