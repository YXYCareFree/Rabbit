//
//  ShareView.m
//  YouTo
//
//  Created by apple on 2018/11/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareView.h"
#import <UMShare/UMShare.h>

@interface ShareView ()

@property (nonatomic, strong) UIView *vBg;

@end

@implementation ShareView

+ (void)share{
    ShareView *view = [[ShareView alloc] init];
    [view setUI];
}

- (void)setUI{
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
        return;
    }
    
    [KEY_WINDOW addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    self.vBg = [[UIView alloc] init];
//    self.vBg.backgroundColor = UIColor.clearColor;
    [self addSubview:self.vBg];
    [self.vBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(-20 - HOME_INDICATOR_HEIGHT));
    }];
    
    YXYButton *btn = [[YXYButton alloc] init];
    btn.title(@"取消", UIControlStateNormal).titleFont(Font_PingFang_Medium(18)).color(Color_Main, UIControlStateNormal).backgroundColor = WhiteColor;
    [btn setCornerRadius:5];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.vBg addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.height.equalTo(@40);
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
    }];
    
    UIView *vbg = [[UIView alloc] init];
    vbg.backgroundColor = WhiteColor;
    [vbg setCornerRadius:5];
    [self.vBg addSubview:vbg];
    [vbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vBg);
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.bottom.equalTo(btn.mas_top).offset(-15);
    }];
    YXYButton *wx = [[YXYButton alloc] init];
    wx.title(@"微信", UIControlStateNormal).titleFont(Font_PingFang_Medium(14)).color(Color_3, UIControlStateNormal);
    [wx addTarget:self action:@selector(wxClicked) forControlEvents:UIControlEventTouchUpInside];
    [vbg addSubview:wx];
    [wx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-15));
        make.centerX.equalTo(@(-70));
    }];
    YXYButton *wx1 = [[YXYButton alloc] init];
    [wx1 addTarget:self action:@selector(wxClicked) forControlEvents:UIControlEventTouchUpInside];
    wx1.setImgae(LoadImageWithName(@"wx"), UIControlStateNormal);
    [vbg addSubview:wx1];
    [wx1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wx.mas_top).offset(-5);
        make.top.equalTo(@(20));
        make.centerX.equalTo(wx);
    }];
    
    YXYButton *wxf = [[YXYButton alloc] init];
    wxf.title(@"朋友圈", UIControlStateNormal).titleFont(Font_PingFang_Medium(14)).color(Color_3, UIControlStateNormal);
    [wxf addTarget:self action:@selector(wxfClicked) forControlEvents:UIControlEventTouchUpInside];
    [vbg addSubview:wxf];
    [wxf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-15));
        make.centerX.equalTo(@(70));
    }];
    YXYButton *wxf1 = [[YXYButton alloc] init];
    [wxf1 addTarget:self action:@selector(wxClicked) forControlEvents:UIControlEventTouchUpInside];
    wxf1.setImgae(LoadImageWithName(@"wxf"), UIControlStateNormal);
    [vbg addSubview:wxf1];
    [wxf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wx.mas_top).offset(-5);
        make.top.equalTo(@(20));
        make.centerX.equalTo(wxf);
    }];
}

- (void)wxClicked{
    [self shareWithPlatformType:UMSocialPlatformType_WechatSession];
}

- (void)wxfClicked{
    [self shareWithPlatformType:UMSocialPlatformType_WechatTimeLine];
}

- (void)shareWithPlatformType:(UMSocialPlatformType)type{
    
    [self requestShareData:^(NSDictionary *dict) {

        UMSocialMessageObject *msg = [UMSocialMessageObject messageObject];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict valueForKey:@"img"]]];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[dict valueForKey:@"title"] descr:[dict valueForKey:@"content"] thumImage:[UIImage imageWithData:data]];//@"head"
        NSString *urlstr = [dict valueForKey:@"linkUrl"];
        //设置网页地址
        shareObject.webpageUrl = urlstr;
        msg.shareObject = shareObject;
        //                    msg.title = dict[@"title"];
        //                    msg.text = dict[@"msg"];
        [[UMSocialManager defaultManager] shareToPlatform:type messageObject:msg currentViewController:CurrentVC completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    }];
}

- (void)requestShareData:(void(^)(NSDictionary *dict))completion{
    YXYRequest *request = [[YXYRequest alloc] init];
    request.apiName = @"/app/member/share/sharePage";
    request.params = @{};
    request.success = ^(id obj) {
        if (completion) {
            completion(obj);
        }
    };
    request.failure = ^(NSString *msg, NSError *error) {

    };
    [RequestClient startRequest:request];
}

- (void)dismiss{
    [UIView animateWithDuration:.25 animations:^{
        [self setNeedsLayout];
        [self.vBg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@300);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
