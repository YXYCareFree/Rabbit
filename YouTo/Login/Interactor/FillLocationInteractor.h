//
//  FillLocationInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FillLocationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FillLocationInteractor : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) FillLocationController *vc;

@property (nonatomic, copy) void(^RemoveFuture)(NSString *city);

@property (nonatomic, copy) void(^RemoveAgo)(NSString *city);


- (void)getCurrentLocation;

- (void)addFutureCityClicked;

- (void)addDidCityClicked;

- (void)btnFinishClicked;

@end

NS_ASSUME_NONNULL_END
