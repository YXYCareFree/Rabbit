//
//  PublishController.m
//  YouTo
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PublishController.h"
#import "PublishInteractor.h"

@interface PublishController ()

@property (nonatomic, strong) PublishInteractor *interactor;
@property (nonatomic, strong) UIView *vPublishCity;

@end

@implementation PublishController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addEndEditingTapGesture];
    [self.btnBack setImage:LoadImageWithName(@"publish_close") forState:UIControlStateNormal];
}

- (void)setUI{

    if (self.type == PublishControllerTypeHelp) {
        self.lblTitle.text = @"发布求助";
        self.lblPlaceHolder.text = @"详细的写一下你的问题";
        [self.view addSubview:self.titleTextField];
        [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
            make.left.equalTo(@20);
            make.right.equalTo(@(-15));
        }];
        [self.view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.top.equalTo(self.titleTextField.mas_bottom).offset(15);
            make.height.mas_greaterThanOrEqualTo(@100);
        }];
    }else{
        self.lblTitle.title(@"发布心情");
        self.lblPlaceHolder.text = @"你想要分享什么，发出来吧...";
        [self.view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.height.mas_greaterThanOrEqualTo(@100);
        }];
    }
    
    [self.textView addSubview:self.lblPlaceHolder];
    [self.lblPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.top.equalTo(@6);
    }];
    
    [self.vNavBar addSubview:self.btnPublish];
    [self.btnPublish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.lblTitle);
        make.height.equalTo(@22);
    }];
    
    [self.view addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
    }];
    
    [self.view addSubview:self.vPublishCity];
    [self.vPublishCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.photoView.mas_bottom).offset(25);
        make.height.equalTo(@28);
    }];

    [self.view addSubview:self.btnLocation];
    [self.btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.vPublishCity.mas_bottom).offset(15);
        make.height.equalTo(@28);
    }];
    
    if (self.type == PublishControllerTypeMood) {
        [self.view addSubview:self.btnSetting];
        [self.btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.height.equalTo(@28);
            make.centerY.equalTo(self.vPublishCity);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.btnSetting.imageEdgeInsets = UIEdgeInsetsMake(0, self.btnSetting.titleLabel.bounds.size.width - 5, 0, 0);
            });
        }];
    }
}

- (void)setType:(PublishControllerType)type{
    _type = type;
    [self setUI];
}

- (YXYButton *)btnPublish{
    if (!_btnPublish) {
        _btnPublish = YXYButton.new;
        _btnPublish.title(@" 发布 ", UIControlStateNormal).color(ColorWithHex(@"999999"), UIControlStateNormal).titleFont(Font_PingFang_Medium(14));
        _btnPublish.backgroundColor = Color_E;
        [_btnPublish addTarget:self.interactor action:@selector(publishClicked) forControlEvents:UIControlEventTouchUpInside];
        _btnPublish.enabled = NO;
        [_btnPublish setCornerRadius:5];
    }
    return _btnPublish;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.font = Font(15);
        _textView.delegate = self.interactor;
    }
    return _textView;
}

- (UITextField *)titleTextField{
    if (!_titleTextField) {
        _titleTextField = UITextField.new;
        _titleTextField.font = Font_PingFang_Medium(16);
        _titleTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"输入你的问题标题" attributes:@{NSFontAttributeName: Font(16), NSForegroundColorAttributeName: Color_6}];;
    }
    return _titleTextField;
}

- (YXYLabel *)lblPlaceHolder{
    if (!_lblPlaceHolder) {
        _lblPlaceHolder = YXYLabel.new;
        _lblPlaceHolder.color(Color_6).titleFont(Font(15));
    }
    return _lblPlaceHolder;
}

- (YXYButton *)btnLocation{
    if (!_btnLocation) {
        _btnLocation = YXYButton.new;
        _btnLocation.adjustsImageWhenHighlighted = NO;
        _btnLocation.backgroundColor = Color_E;
        [_btnLocation setCornerRadius:14];
        [_btnLocation setImage:LoadImageWithName(@"publish_location") forState:UIControlStateNormal];
        _btnLocation.titleFont(Font(13)).title(@"   获取当前位置  ", UIControlStateNormal).color(ColorWithHex(@"999999"), UIControlStateNormal);
        _btnLocation.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [_btnLocation addTarget:self.interactor action:@selector(getCurrentLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLocation;
}

- (UIView *)vPublishCity{
    if (!_vPublishCity) {
        _vPublishCity = [[UIView alloc] init];
        _vPublishCity.backgroundColor = Color_Main;
        [_vPublishCity setCornerRadius:14];
        YXYLabel *lbl = [[YXYLabel alloc] init];
        lbl.title(@"发布到").color(WhiteColor).titleFont(Font(13));
        [_vPublishCity addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(self.vPublishCity);
        }];
        [_vPublishCity addSubview:self.btnAtCity];
        [self.btnAtCity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbl.mas_right).offset(15);
            make.centerY.equalTo(self.vPublishCity);
        }];
        YXYButton *btnImg = [[YXYButton alloc] init];
        btnImg.setImgae(LoadImageWithName(@"pulldown"),UIControlStateNormal);
        [btnImg addTarget:self.interactor action:@selector(atCityClicked) forControlEvents:UIControlEventTouchUpInside];
        [_vPublishCity addSubview:btnImg];
        [btnImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.btnAtCity);
            make.left.equalTo(self.btnAtCity.mas_right).offset(3);
            make.right.equalTo(@(-10));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(atCityClicked)];
        [_vPublishCity addGestureRecognizer:tap];
    }
    return _vPublishCity;
}

- (YXYButton *)btnAtCity{
    if (!_btnAtCity) {
        _btnAtCity = YXYButton.new;
        _btnAtCity.color(WhiteColor, UIControlStateNormal).title(GetCity, UIControlStateNormal).titleFont(Font(13));
        [_btnAtCity addTarget:self.interactor action:@selector(atCityClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAtCity;
}

- (YXYSelectPhotoView *)photoView{
    if (!_photoView) {
        _photoView = [[YXYSelectPhotoView alloc] init];
        WEAKSELF;
        _photoView.AddPhotoBlock = ^{
            [weakSelf.interactor addPhotoClicked];
        };
    }
    return _photoView;
}

- (YXYButton *)btnSetting{
    if (!_btnSetting) {
        _btnSetting = YXYButton.new;
        _btnSetting.adjustsImageWhenHighlighted = NO;
        _btnSetting.title(@"  广场可见   ", UIControlStateNormal).color(WhiteColor, UIControlStateNormal).titleFont(Font_PingFang_Medium(13));
        [_btnSetting setCornerRadius:14];
        [_btnSetting addTarget:self.interactor action:@selector(btnSettingClicked:) forControlEvents:UIControlEventTouchUpInside];
        _btnSetting.backgroundColor = Color_Main;
        [_btnSetting setImage:LoadImageWithName(@"pulldown") forState:UIControlStateNormal];
    }
    return _btnSetting;
}

- (PublishInteractor *)interactor{
    if (!_interactor) {
        _interactor = PublishInteractor.new;
        _interactor.vc = self;
    }
    return _interactor;
}
@end
