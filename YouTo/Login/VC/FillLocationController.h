//
//  FillLocationController.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "MultiCityView.h"

typedef NS_ENUM(NSUInteger, FillLocationControllerType) {
    FillLocationControllerTypeLogin,
    FillLocationControllerTypeEdit,
};
NS_ASSUME_NONNULL_BEGIN

@interface FillLocationController : YouToViewController

@property (nonatomic, strong) UITextField *addressTextF;
@property (nonatomic, strong) UITextField *birthAreaTextF;

@property (nonatomic, strong) MultiCityView *vDid;
@property (nonatomic, strong) MultiCityView *vFuture;

@property (nonatomic, assign) FillLocationControllerType type;

@end

NS_ASSUME_NONNULL_END
