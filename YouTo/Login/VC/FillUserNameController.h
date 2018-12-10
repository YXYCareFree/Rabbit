//
//  FillUserNameController.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FillUserNameController : YouToViewController

@property (nonatomic, strong) UITextField *nickTextF;
@property (nonatomic, strong) UITextField *sexTextF;
@property (nonatomic, strong) UITextField *birthdayTextF;

@property (weak, nonatomic) IBOutlet UIButton *btnUserIcon;

@end

NS_ASSUME_NONNULL_END
