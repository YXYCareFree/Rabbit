//
//  CreateGroupController.m
//  YouTo
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CreateGroupController.h"
#import "CreateGroupInteractor.h"

@interface CreateGroupController ()

@property (nonatomic, strong) CreateGroupInteractor *interactor;

@end

@implementation CreateGroupController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    [self addEndEditingTapGesture];
    self.lblTitle.text = @"创建群组";
    [self.view addSubview:self.btnPhoto];
    [self.btnPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@112);
    }];
    
    UIView *vName = [self createWithTitle:@"群昵称" textField:self.txtFNickName];
    [self.view addSubview:vName];
    [vName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPhoto.mas_bottom).offset(35);
        make.height.equalTo(@44);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
    }];
    
    UIView *vIntroduce = [self createWithTitle:@"群介绍" textField:self.txtVIntroduce];
    [self.view addSubview:vIntroduce];
    [vIntroduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vName.mas_bottom).offset(25);
        make.height.equalTo(@150);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
    }];
    [self.txtVIntroduce addSubview:self.lblIntroduce];
    [self.lblIntroduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@5);
        make.right.equalTo(@0);
    }];
    
    UIView *vCity = [self createWithTitle:@"城市" textField:self.txtFCity];
    [self.view addSubview:vCity];
    [vCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vIntroduce.mas_bottom).offset(25);
        make.height.equalTo(@44);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
    }];
    
    YXYButton *next = [[YXYButton alloc] init];
    next.setImgae(LoadImageWithName(@"login_next"), UIControlStateNormal);
    [next addTarget:self.interactor action:@selector(nextClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-27));
        make.height.equalTo(@14);
        make.width.equalTo(@28);
        make.bottom.equalTo(@(-HOME_INDICATOR_HEIGHT - 30));
    }];
    YXYButton *nex = [[YXYButton alloc] init];
    nex.titleFont(Font_PingFang_Medium(18)).color(ColorWithHex(@"b3b3b3"), UIControlStateNormal).title(@"下一步", UIControlStateNormal);
    [nex addTarget:self.interactor action:@selector(nextClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nex];
    [nex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(next);
        make.right.equalTo(next.mas_left).offset(-5);
    }];
}

- (UIView *)createWithTitle:(NSString *)title textField:(UIView *)textField{
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
        make.width.equalTo(@50);
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
    
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v.mas_right).offset(15);
        make.top.bottom.right.equalTo(@0);
    }];
    
    return view;
}

- (YXYButton *)btnPhoto{
    if (!_btnPhoto) {
        _btnPhoto = [[YXYButton alloc] init];
        [_btnPhoto setContentMode:UIViewContentModeScaleAspectFill];
        [_btnPhoto setCornerRadius:56];
        _btnPhoto.setImgae(LoadImageWithName(@"default_icon"), UIControlStateNormal);
        [_btnPhoto addTarget:self.interactor action:@selector(btnPhotoClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPhoto;
}

- (YXYTextField *)txtFCity{
    if (!_txtFCity) {
        _txtFCity = [[YXYTextField alloc] init];
        _txtFCity.baseView = _txtFCity;
        _txtFCity.delegate = self.interactor;
    }
    return _txtFCity;
}

- (YXYTextField *)txtFNickName{
    if (!_txtFNickName) {
        _txtFNickName = [[YXYTextField alloc] init];
        _txtFNickName.delegate = self.interactor;
        _txtFNickName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"20字以内" attributes:@{NSForegroundColorAttributeName: ColorWithHex(@"b2b2b2"), NSFontAttributeName: Font(12)}];
    }
    return _txtFNickName;
}

- (UITextView *)txtVIntroduce{
    if (!_txtVIntroduce) {
        _txtVIntroduce = [[UITextView alloc] init];
        _txtVIntroduce.delegate = self.interactor;
        _txtVIntroduce.font = Font(13);
    }
    return _txtVIntroduce;
}

- (YXYLabel *)lblIntroduce{
    if (!_lblIntroduce) {
        _lblIntroduce = [[YXYLabel alloc] init];
        _lblIntroduce.numberOfLines = 0;
        _lblIntroduce.title(@"群介绍(最多120字)...").titleFont(Font(14)).color(ColorWithHex(@"b2b2b2"));
    }
    return _lblIntroduce;
}

- (CreateGroupInteractor *)interactor{
    if (!_interactor) {
        _interactor = [[CreateGroupInteractor alloc] init];
        _interactor.vc = self;
    }
    return _interactor;
}
@end
