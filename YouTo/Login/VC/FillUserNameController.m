//
//  FillUserNameController.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FillUserNameController.h"
#import "FillUserNameInteractor.h"

@interface FillUserNameController ()

@property (nonatomic, strong) FillUserNameInteractor *interactor;

@end

@implementation FillUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.vBackHidden = YES;
    [self addEndEditingTapGesture];
    
    [self.btnUserIcon setCornerRadius:56];
    UIView *vNick = [self createWithTitle:@"昵称" textField:self.nickTextF btn:nil];
    [self.view addSubview:vNick];
    [vNick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUserIcon.mas_bottom).offset(40);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
    }];
    
    UIButton *btn = UIButton.new;
    [btn setImage:LoadImageWithName(@"login_select") forState:UIControlStateNormal];
    [btn addTarget:self.interactor action:@selector(selectSexClicked) forControlEvents:UIControlEventTouchUpInside];
    UIView *vSex = [self createWithTitle:@"性别" textField:self.sexTextF btn:btn];
    [self.view addSubview:vSex];
    [vSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vNick.mas_bottom).offset(25);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
    }];
    
    UIView *vBirthday = [self createWithTitle:@"生日" textField:self.birthdayTextF btn:nil];
    [self.view addSubview:vBirthday];
    [vBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vSex.mas_bottom).offset(25);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
    }];
}

- (UIView *)createWithTitle:(NSString *)title textField:(UITextField *)textField btn:(UIButton *)btn{
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.clearColor;
    [view setCornerRadius:5];
    view.layer.borderWidth = 1;
    view.layer.borderColor = Color_C.CGColor;
    
    YXYLabel *lbl = YXYLabel.new;
    lbl.title(title).color(Color_3).titleFont(Font_PingFang_Medium(16));
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(@15);
        make.width.equalTo(@33);
    }];
    
    UIView *v = UIView.new;
    v.backgroundColor = Color_E;
    [view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.left.equalTo(lbl.mas_right).offset(15);
        make.height.equalTo(@25);
        make.centerY.equalTo(view);
    }];
    
    if (btn) {
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-18));
            make.centerY.equalTo(view);
            make.width.equalTo(@9);
            make.height.equalTo(@6);
        }];
        
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v.mas_right).offset(15);
            make.top.bottom.equalTo(@0);
            make.right.equalTo(btn.mas_left).offset(0);
        }];
    }else{
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(v.mas_right).offset(15);
            make.top.bottom.right.equalTo(@0);
        }];
    }
    return view;
}

- (IBAction)nextStep:(id)sender {
    [self.interactor nextStep];
}

- (IBAction)nextStepClicked:(id)sender {
    [self.interactor nextStep];
}

- (IBAction)userIconClicked:(id)sender {
    [self.interactor selectUserIconClicked:sender];
}

- (UITextField *)nickTextF{
    if (!_nickTextF) {
        _nickTextF = UITextField.new;
        _nickTextF.font = Font_PingFang_Medium(16);
        _nickTextF.textColor = Color_3;
    }
    return _nickTextF;
}

- (UITextField *)sexTextF{
    if (!_sexTextF) {
        _sexTextF = UITextField.new;
        _sexTextF.font = Font_PingFang_Medium(16);
        _sexTextF.textColor = Color_3;
        _sexTextF.delegate = self.interactor;
    }
    return _sexTextF;
}

- (UITextField *)birthdayTextF{
    if (!_birthdayTextF) {
        _birthdayTextF = UITextField.new;
        _birthdayTextF.font = Font_PingFang_Medium(16);
        _birthdayTextF.textColor = Color_3;
        _birthdayTextF.delegate = self.interactor;
    }
    return _birthdayTextF;
}

- (FillUserNameInteractor *)interactor{
    if (!_interactor) {
        _interactor = FillUserNameInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
