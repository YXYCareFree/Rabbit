//
//  CreateGroupController.h
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "YXYTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateGroupController : YouToViewController

@property (nonatomic, strong) YXYButton *btnPhoto;
@property (nonatomic, strong) YXYTextField *txtFNickName;
@property (nonatomic, strong) YXYTextField *txtFCity;
@property (nonatomic, strong) UITextView *txtVIntroduce;
@property (nonatomic, strong) YXYLabel *lblIntroduce;

@end

NS_ASSUME_NONNULL_END
