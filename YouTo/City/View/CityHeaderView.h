//
//  CityHeaderView.h
//  YouTo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityAbstractModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityHeaderView : UIView

@property (nonatomic, strong) YXYButton *btnCity;

@property (nonatomic, copy) void(^SelectCityBlock)(YXYButton *btn);

@property (nonatomic, strong) CityAbstractModel *model;

@end

NS_ASSUME_NONNULL_END
