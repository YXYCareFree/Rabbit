//
//  CityTabBarInteractor.h
//  YouTo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYBaseInteractor.h"
@class CityTabBarController;

NS_ASSUME_NONNULL_BEGIN

@interface CityTabBarInteractor : YXYBaseInteractor<UIGestureRecognizerDelegate>

@property (nonatomic, weak) CityTabBarController *vc;


- (void)tableViewPanGesyure:(UIPanGestureRecognizer *)pan;

@end

NS_ASSUME_NONNULL_END
