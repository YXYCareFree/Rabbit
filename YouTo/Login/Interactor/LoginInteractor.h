//
//  LoginInteractor.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginInteractor : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) LoginController *vc;

- (void)btnLoginClicked;

- (void)getAuthCode:(UIButton *)btn;

- (void)btnProtocolClicked;

- (void)wechatLoginClicked;

@end

NS_ASSUME_NONNULL_END
