//
//  ApplyJoinGroupController.m
//  YouTo
//
//  Created by apple on 2018/11/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ApplyJoinGroupController.h"
#import "AccountManager.h"
#import "GroupAdapter.h"

@interface ApplyJoinGroupController ()<UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) YXYButton *btnJoin;

@property (nonatomic, strong) YXYLabel *lblPlaceHolder;

@end

@implementation ApplyJoinGroupController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setRemarkId:(NSString *)remarkId{
    _remarkId = remarkId;
    self.lblPlaceHolder.text = @"设置备注，不多于10个字";
    self.lblTitle.text = @"设置备注";
}

- (void)setType:(ApplyJoinGroupControllerType)type{
    _type = type;
    switch (self.type) {
        case ApplyJoinGroupControllerTypeSign:{
            self.lblTitle.title(@"个性签名");
            self.lblPlaceHolder.text = @"请输入您的个性签名，让我们更好的了解您";
        }  break;
        case ApplyJoinGroupControllerTypeApply:{
            self.lblTitle.title(@"申请加群");
            self.lblPlaceHolder.text = @"说说你的加群理由吧，请保持30字以内";
        }   break;
        case ApplyJoinGroupControllerTypeFeedback:{
            self.lblTitle.title(@"用户反馈");
            self.lblPlaceHolder.text = @"请输入您的反馈";
        }   break;
        case ApplyJoinGroupControllerTypeNickName:{
            self.lblTitle.title(@"修改昵称");
            self.lblPlaceHolder.text = @"请设置您的昵称";
        }break;
        case ApplyJoinGroupControllerTypeRefuse:{
            self.lblTitle.title(@"拒绝原因");
            self.lblPlaceHolder.text = @"请输入您的拒绝原因";
        }break;
        case ApplyJoinGroupControllerTypeGroupNickName:{
            self.lblTitle.title(@"设置群名片");
            self.lblPlaceHolder.text = @"请设置您的群名片";
        }break;
        default:
            break;
    }
    
    [self setUI];
}

- (void)setUI{

    [self addEndEditingTapGesture];
    
    [Self_View addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vNavBar.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@80);
    }];
    [self.textView addSubview:self.lblPlaceHolder];
    [self.lblPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.top.equalTo(@6);
    }];
    [self.textView becomeFirstResponder];
    
    if (self.type == ApplyJoinGroupControllerTypeSign) {
        YXYButton *btnConfirm = [[YXYButton alloc] init];
        btnConfirm.titleFont(Font(14)).color(Color_6, UIControlStateNormal).title(@"确认", UIControlStateNormal);
        [btnConfirm addTarget:self action:@selector(btnJoinClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.vNavBar addSubview:btnConfirm];
        [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lblTitle);
            make.right.equalTo(@(-15));
        }];
    }else{
        [Self_View addSubview:self.btnJoin];
        [self.btnJoin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@160);
            make.height.equalTo(@44);
            make.centerX.equalTo(Self_View);
            make.top.equalTo(@289);
        }];
    }
}

- (void)btnJoinClicked{
    switch (self.type) {
        case ApplyJoinGroupControllerTypeSign:{
            if (self.remarkId) {
                YXYRequest *request = YXYRequest.new;
                request.apiName = @"/app/member/memberNameRemark/addMemberNameRemark";
                request.params = @{@"remark": self.textView.text, @"beMemberId": self.remarkId};
                request.success = ^(id obj) {
                    [MBProgressHUD showText:@"设置备注成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                };
                request.failure = ^(NSString *msg, NSError *error) {
                    
                };
                [RequestClient startRequest:request];
            }else{
                [AccountManager refreshUserInfoWithParams:@{@"personalizedSignature": self.textView.text} completion:^(UserModel * _Nonnull model) {
                    [MBProgressHUD showText:@"更新成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        } break;
        case ApplyJoinGroupControllerTypeFeedback:{
            YXYRequest *request = YXYRequest.new;
            request.apiName = @"/app/member/memberSuggest/addMemberSuggest";
            request.params = @{@"info": self.textView.text};
            request.success = ^(id obj) {
                [MBProgressHUD showText:@"反馈成功"];
                [self.navigationController popViewControllerAnimated:YES];
            };
            request.failure = ^(NSString *msg, NSError *error) {
     
            };
            [RequestClient startRequest:request];
        } break;
        case ApplyJoinGroupControllerTypeApply:{
            [GroupAdapter applyJoinGroup:self.groupId applyReason:self.textView.text completion:^(BOOL success, id response) {
                if (success) {
                    [MBProgressHUD showText:@"申请成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        } break;
        case ApplyJoinGroupControllerTypeNickName:{
            [AccountManager refreshUserInfoWithParams:@{@"nickName": self.textView.text} completion:^(UserModel * _Nonnull model) {
                [MBProgressHUD showText:@"更新成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } break;
        case ApplyJoinGroupControllerTypeRefuse:{
            if (self.BtnClickedBlock) {
                self.BtnClickedBlock(self.textView.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }break;
        case ApplyJoinGroupControllerTypeGroupNickName:{
            if (self.BtnClickedBlock) {
                self.BtnClickedBlock(self.textView.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }break;
        default:
            break;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.lblPlaceHolder.hidden = text.length + textView.text.length;
    if (textView.text.length == 1 && [text isEqualToString:@""]) {
        self.lblPlaceHolder.hidden = NO;
    }
    if (self.remarkId) {
        if ((textView.text.length + text.length) > 10) {
            return NO;
        }
    }
    return YES;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.delegate = self;
    }
    return _textView;
}

- (YXYButton *)btnJoin{
    if (!_btnJoin) {
        _btnJoin = YXYButton.new;
        _btnJoin.backgroundColor = Color_Main;
        [_btnJoin setCornerRadius:22];
        _btnJoin.titleFont(Font_PingFang_Medium(18)).color(WhiteColor, UIControlStateNormal);
        if (self.type == ApplyJoinGroupControllerTypeApply) {
            _btnJoin.title(@"申请加群", UIControlStateNormal);
        }else{
            _btnJoin.title(@"立即提交", UIControlStateNormal);
        }
        [_btnJoin addTarget:self action:@selector(btnJoinClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnJoin;
}

- (YXYLabel *)lblPlaceHolder{
    if (!_lblPlaceHolder) {
        _lblPlaceHolder = [[YXYLabel alloc] init];
        _lblPlaceHolder.titleFont(Font(15)).color(Color_3);
    }
    return _lblPlaceHolder;
}
@end
