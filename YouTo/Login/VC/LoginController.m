//
//  LoginController.m
//  YouTo
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LoginController.h"
#import "LoginInteractor.h"
#import "DHGuidePageHUD.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"

@interface LoginController ()

@property (nonatomic, strong) LoginInteractor *interactor;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIView *vPlayerBg;

@end

@implementation LoginController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view sendSubviewToBack:self.vPlayerBg];
    UIView *v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:v];
    [self.view insertSubview:v aboveSubview:self.vPlayerBg];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:@[@"Guide1", @"Guide2", @"Guide3"] buttonIsHidden:YES];
        guidePage.imagePageControl.hidden = YES;
        guidePage.btnSkip.backgroundColor = Color_Main;
        [guidePage.btnSkip setTitleColor:WhiteColor forState:UIControlStateNormal];
        guidePage.slideInto = NO;
        guidePage.BtnSkipClicked = ^{
            
        };
        [KEY_WINDOW addSubview:guidePage];
    }
    [self.player playTheIndex:0];

    [self setUI];
    WEAKSELF;
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        [weakSelf.player.currentPlayerManager replay];
    };
}

- (void)setUI{
    self.vBackHidden = YES;
    [self addEndEditingTapGesture];

    self.lblThird.hidden = self.btnWechat.hidden = !IsInstallWX;
    
    self.phoneTextField.imgLeft.image = LoadImageWithName(@"phone");
    self.phoneTextField.type = PhoneType;
    self.phoneTextField.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName: Font(15), NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6]}];
    self.authCodeTextField.imgLeft.image = LoadImageWithName(@"authCode");
    self.authCodeTextField.type = AuthCodeType;
    self.authCodeTextField.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName: Font(15), NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6]}];;
    self.authCodeTextField.textField.delegate = self.interactor;
    
    [self.btnLogin setCornerRadius:20];
    self.btnLogin.enabled = NO;
    [self.btnLogin addTarget:self.interactor action:@selector(btnLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.authCodeTextField.btnAuthCode addTarget:self.interactor action:@selector(getAuthCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnProtocol addTarget:self.interactor action:@selector(btnProtocolClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.btnWechat addTarget:self.interactor action:@selector(wechatLoginClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setType:(LoginType)type{
    _type = type;
    if (type == Login) {
        self.lblLoginType.text = @"手机号登录";
        self.lblThird.hidden = self.btnWechat.hidden = NO;
    }else{
        self.lblLoginType.text = @"绑定手机号";
        self.lblThird.hidden = self.btnWechat.hidden = YES;
    }
}

- (IBAction)protocolClicked:(id)sender {
    PushVCWithClassName(@"ProtocolViewController");
}

- (ZFPlayerController *)player{
    if (!_player) {
        ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
        UIView *vbg = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:vbg];
        self.vPlayerBg = vbg;
        _player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:vbg];
        playerManager.scalingMode = ZFPlayerScalingModeAspectFill;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"mp4"];
        _player.assetURL = [NSURL fileURLWithPath:path];
    }
    return _player;
}

- (LoginInteractor *)interactor{
    if (!_interactor) {
        _interactor = LoginInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
