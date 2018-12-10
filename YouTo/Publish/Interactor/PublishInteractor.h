//
//  PublishInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublishController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublishInteractor : NSObject<UITextViewDelegate>

@property (nonatomic, weak) PublishController *vc;

- (void)addPhotoClicked;

- (void)publishClicked;

- (void)getCurrentLocationClicked:(YXYButton *)btn;

- (void)atCityClicked;

- (void)btnSettingClicked:(YXYButton *)btn;
@end

NS_ASSUME_NONNULL_END
