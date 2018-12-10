//
//  LoginController.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YouToViewController.h"
#import "YXYLoginTextField.h"

typedef NS_ENUM(NSUInteger, LoginType) {
    Login,
    Bind,
};

NS_ASSUME_NONNULL_BEGIN

@interface LoginController : YouToViewController

@property (weak, nonatomic) IBOutlet UILabel *lblLoginType;

@property (weak, nonatomic) IBOutlet YXYLoginTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet YXYLoginTextField *authCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnProtocol;
@property (weak, nonatomic) IBOutlet UIButton *btnWechat;

@property (weak, nonatomic) IBOutlet UILabel *lblThird;

@property (nonatomic, assign) LoginType type;

@end

NS_ASSUME_NONNULL_END
