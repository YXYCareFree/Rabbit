//
//  YXYLoginTextField.h
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YXYLoginTextFieldType) {
    PhoneType,
    AuthCodeType,
};

NS_ASSUME_NONNULL_BEGIN

@interface YXYLoginTextField : UIView

@property (nonatomic, strong) UIImageView *imgLeft;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) YXYLoginTextFieldType type;

@property (nonatomic, strong) UIButton *btnAuthCode;

@end

NS_ASSUME_NONNULL_END
