//
//  FillLocationController.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FillLocationController.h"
#import "FillLocationInteractor.h"
#import "YXYTabBarController.h"
#import "AccountManager.h"

@interface FillLocationController ()

@property (nonatomic, strong) FillLocationInteractor *interactor;

@end

@implementation FillLocationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setType:(FillLocationControllerType)type{
    _type = type;
    if (type == FillLocationControllerTypeEdit) {
        self.lblTitle.text = @"城市信息";
    }
    [self setUI];
}

- (void)setUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [Self_View addGestureRecognizer:tap];
    [self.btnBack setImage:LoadImageWithName(@"back_gray") forState:UIControlStateNormal];
    
    YXYButton *btnSkip = YXYButton.new;
    btnSkip.title(@"跳过", UIControlStateNormal).titleFont(Font_PingFang_Medium(14)).color(ColorWithHex(@"999999"), UIControlStateNormal);
    [btnSkip addTarget:self action:@selector(skipClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.vNavBar addSubview:btnSkip];
    [btnSkip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.equalTo(self.lblTitle);
    }];
    if (self.type == FillLocationControllerTypeEdit) {
        btnSkip.hidden = YES;
    }
    
    UserModel *model = [AccountManager getUserInfo];
    
    self.addressTextF = [UITextField new];
    self.addressTextF.delegate = self.interactor;
    self.addressTextF.text = model.currentLiveAddress?:@"";
    YXYButton *btn = YXYButton.new;
    btn.title(@"获取当前定位", UIControlStateNormal).titleFont(Font(13)).color(ColorWithHex(@"2febeb"), UIControlStateNormal);
    [btn addTarget:self.interactor action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    UIView *vAddress = [self createWithTitle:@"现居地" textField:self.addressTextF btn:btn];
    [self.view addSubview:vAddress];
    [vAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnSkip.mas_bottom).offset(35);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
    }];
    
    self.birthAreaTextF = UITextField.new;
    self.birthAreaTextF.delegate = self.interactor;
    self.birthAreaTextF.text = model.birthAddress?:@"";
    UIView *vbirthArea = [self createWithTitle:@"出生地" textField:self.birthAreaTextF btn:nil];
    [self.view addSubview:vbirthArea];
    [vbirthArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vAddress.mas_bottom).offset(25);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.equalTo(@44);
    }];
    
    YXYButton *btnDid = YXYButton.new;
    btnDid.bgImgae(LoadImageWithName(@"login_add"), UIControlStateNormal);
    [btnDid addTarget:self.interactor action:@selector(addDidCityClicked) forControlEvents:UIControlEventTouchUpInside];
    MultiCityView *v = MultiCityView.new;
    self.vDid = v;
    self.vDid.RemoveCity = self.interactor.RemoveAgo;
    UIView *vDid = [self createWithTitle:@"曾去过" textField:v btn:btnDid];
    [self.view addSubview:vDid];
    [vDid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vbirthArea.mas_bottom).offset(25);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    YXYButton *btnFuture = YXYButton.new;
    btnFuture.bgImgae(LoadImageWithName(@"login_add"), UIControlStateNormal);
    [btnFuture addTarget:self.interactor action:@selector(addFutureCityClicked) forControlEvents:UIControlEventTouchUpInside];
    MultiCityView *v1 = [[MultiCityView alloc] init];
    self.vFuture = v1;
    self.vFuture.RemoveCity = self.interactor.RemoveFuture;
    UIView *vFuture = [self createWithTitle:@"未来想去" textField:v1 btn:btnFuture];
    [self.view addSubview:vFuture];
    [vFuture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vDid.mas_bottom).offset(25);
        make.left.equalTo(@38);
        make.right.equalTo(@(-38));
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.vDid.dataSource = [NSMutableArray arrayWithArray:[model.agoGoCityName?:@"" componentsSeparatedByString:@"、"]];
        self.vFuture.dataSource = [NSMutableArray arrayWithArray:[model.futureGoCityName?:@"" componentsSeparatedByString:@"、"]];
    });
    
    YXYButton *btnFinish = YXYButton.new;
    [btnFinish setCornerRadius:22];
    btnFinish.title(@"完成", UIControlStateNormal).color(UIColor.whiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(18));
    btnFinish.backgroundColor = Color_Main;
    [btnFinish addTarget:self action:@selector(btnFinishClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFinish];
    [btnFinish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-25));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@120);
        make.height.equalTo(@44);
    }];
}

- (void)skipClicked{
    KEY_WINDOW.rootViewController = [YXYTabBarController new];
}

- (void)btnFinishClicked{
    [self.interactor btnFinishClicked];
}

- (UIView *)createWithTitle:(NSString *)title textField:(UIView *)textField btn:(UIButton *)btn{
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.clearColor;
    [view setCornerRadius:5];
    view.layer.borderWidth = 1;
    view.layer.borderColor = Color_C.CGColor;
    
    YXYLabel *lbl = YXYLabel.new;
    lbl.title(title).color(Color_3).titleFont(Font_PingFang_Medium(16));
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@(13));
        if ([textField isKindOfClass:[UITextField class]]) {
            make.width.equalTo(@48);
        }
    }];
    
    UIView *v = UIView.new;
    v.backgroundColor = Color_E;
    [view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.left.equalTo(lbl.mas_right).offset(15);
        make.height.equalTo(@25);
        make.top.equalTo(@10);
    }];
    
    if (btn) {
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.centerY.equalTo(view);
            if (btn.currentTitle) {
                make.width.equalTo(@85);
            }
        }];
        
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([textField isKindOfClass:[MultiCityView class]]) {
                make.left.equalTo(v.mas_right).offset(15);
                make.top.equalTo(@15);
                make.right.equalTo(btn.mas_left).offset(-15);
                make.bottom.equalTo(@(-15));
            }else{
                make.left.equalTo(v.mas_right).offset(15);
                make.top.bottom.equalTo(@0);
                make.right.equalTo(btn.mas_left).offset(0);
            }
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

- (FillLocationInteractor *)interactor{
    if (!_interactor) {
        _interactor = FillLocationInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
