//
//  FillUserNameInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FillUserNameController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FillUserNameInteractor : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) FillUserNameController *vc;

- (void)selectUserIconClicked:(UIButton *)btn;

- (void)selectSexClicked;

- (void)nextStep;

@end

NS_ASSUME_NONNULL_END
