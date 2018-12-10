//
//  YXYLoginTextField.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "YXYLoginTextField.h"

@interface YXYLoginTextField ()

@property (nonatomic, strong) UIView *vSplit;

@end

@implementation YXYLoginTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}

- (void)setUI{
    [self setCornerRadius:5];
    
}

- (void)setType:(YXYLoginTextFieldType)type{
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    if (type == PhoneType) {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];

        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"+86" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = Font_PingFang_Medium(15);
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@5);
            make.width.equalTo(@40);
        }];
        
        UIView *vSplit = UIView.new;
        vSplit.backgroundColor = Color_E;
        [self addSubview:vSplit];
        [vSplit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.bottom.equalTo(@(-15));
            make.width.equalTo(@1);
            make.left.equalTo(btn.mas_right).offset(5);
        }];
        self.vSplit = vSplit;
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.left.equalTo(self.vSplit.mas_right).offset(10);
        }];
    }else{
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.btnAuthCode];
        self.btnAuthCode.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];
        [self.btnAuthCode setCornerRadius:5];
        [self.btnAuthCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(@(0));
            make.width.equalTo(@96);
            make.top.bottom.equalTo(self);
        }];
        
        self.textField.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];
        [self.textField setCornerRadius:5];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(@0);
            make.right.equalTo(self.btnAuthCode.mas_left).offset(-12);
        }];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
        self.textField.leftView = v;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
    }
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = UITextField.new;
        _textField.tintColor = WhiteColor;
        _textField.textColor = WhiteColor;
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)btnAuthCode{
    if (!_btnAuthCode) {
        _btnAuthCode = UIButton.new;
        [_btnAuthCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_btnAuthCode setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6] forState:UIControlStateNormal];
        _btnAuthCode.titleLabel.font = Font(15);
    }
    return _btnAuthCode;
}

@end
