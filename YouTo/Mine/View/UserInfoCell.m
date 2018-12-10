//
//  UserInfoCell.m
//  YouTo
//
//  Created by apple on 2018/11/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUI{
    UIView *view = [self createView];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setType:(UserInfoCellType)type{
    _type = type;
    [self setUI];
}

- (void)setModel:(UserModel *)model{
    if (!model) return;

    _model = model;
  
    [self.imgVUserIcon sd_setImageWithURL:URLWithStr(model.headImg) placeholderImage:nil];
    self.lblUserName.text = model.nickName;
    NSString *sex;
    if ([model.sex isEqualToString:@"男"]) {
        sex = @"man";
    }else{
        sex = @"woman";
    }
    self.imgVUserSex.image = LoadImageWithName(sex);
    self.lblUserSign.text = model.personalizedSignature;

    if (self.type == UserInfoCellTypeMine) {
        return;
    }
    if (model.currentLiveAddress.length) {
        self.lblCurrAddress.text = model.currentLiveAddress;
    }
//    else{
//        self.lblCurrAddress.text = @"杭州";
//        self.lblCurrAddress.hidden = YES;
//    }
    if (model.birthAddress.length) {
        self.lblBirthAddress.text = model.birthAddress;
    }
//    else{
//        self.lblBirthAddress.text = @"杭州";
//        self.lblBirthAddress.hidden = YES;
//    }
    
    self.lblMatchDegree.text = model.matchValue;
    self.btnFutureCity.title(model.futureGoCityName?:@"", UIControlStateNormal);
    self.btnAgoCity.title(model.agoGoCityName?:@"", UIControlStateNormal);
}

- (UIView *)createView{
    UIView *view = UIView.new;
    view.backgroundColor = UIColor.clearColor;
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithImage:LoadImageWithName(@"userInfo_bg")];
    imgVBg.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imgVBg];
    
    if (self.type == UserInfoCellTypeDynamic && !self.isSelf) {
        YXYLabel *lblMatchDegree = YXYLabel.new;
        self.lblMatchDegree = lblMatchDegree;
        lblMatchDegree.color(ColorWithHex(@"#2febeb")).titleFont(Font_PingFang_Bold(18)).title(@"");
        [view addSubview:lblMatchDegree];
        [lblMatchDegree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-17));
            make.top.equalTo(@(65 + STATUS_BAR_HEIGHT - 20));
        }];
        YXYLabel *lblMatch = YXYLabel.new;
        lblMatch.titleFont(Font_PingFang_Medium(11)).color(UIColor.whiteColor).title(@"匹配值：");
        lblMatch.hidden = YES;
        [view addSubview:lblMatch];
        [lblMatch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lblMatchDegree);
            make.right.equalTo(lblMatchDegree.mas_left).offset(0);
        }];
    }else{
        if (self.type == UserInfoCellTypeMine) {
            [view addSubview:self.btnEdit];
            [self.btnEdit mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-25));
                make.width.height.equalTo(@44);
                make.top.equalTo(@(STATUS_BAR_HEIGHT + 14));
            }];
        }
    }
    
    [view addSubview:self.imgVUserIcon];
    [self.imgVUserIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@84);
        make.centerX.equalTo(view);
        make.top.equalTo(@(15 + NAVIGATION_BAR_HEIGHT));
    }];
    
    self.lblUserName = YXYLabel.new;
    self.lblUserName.color(UIColor.whiteColor).titleFont(Font_PingFang_Bold(18)).title(@"");
    [view addSubview:self.lblUserName];
    [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(self.imgVUserIcon.mas_bottom).offset(13);
    }];
    
    self.lblUserSign = YXYLabel.new;
    self.lblUserSign.color(UIColor.whiteColor).titleFont(Font(13));
    self.lblUserSign.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.lblUserSign];
    [self.lblUserSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.top.equalTo(self.lblUserName.mas_bottom).offset(3);
        if (self.type == UserInfoCellTypeMine) {
            make.bottom.equalTo(@(-10));
        }
    }];
    
    [imgVBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        //        make.height.equalTo(@235);
//        if (self.type == UserInfoCellTypeMine) {
//            make.bottom.equalTo(@0);
//        }
        make.bottom.equalTo(self.lblUserSign);
    }];
    
    if (self.type == UserInfoCellTypeMine){
        return view;
    }else{
 
    }
    
    UIView *vSpit = UIView.new;
    vSpit.backgroundColor = Color_Main;
    [view addSubview:vSpit];
    [vSpit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgVBg.mas_bottom).offset(25);
        make.left.equalTo(@15);
        make.width.equalTo(@3);
        make.height.equalTo(@16);
    }];
    
    YXYLabel *lblCity = YXYLabel.new;
    lblCity.title(@"城市信息").color(Color_3).titleFont(Font_PingFang_Medium(18));
    [view addSubview:lblCity];
    [lblCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vSpit.mas_right).offset(12);
        make.centerY.equalTo(vSpit);
    }];
    
    self.lblCurrAddress = YXYLabel.new;
    UIView *v1 = [self createUIViewWithImage:LoadImageWithName(@"location") title:@"现居地" view:self.lblCurrAddress];
    [view addSubview:v1];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.top.equalTo(lblCity.mas_bottom).offset(8);
        make.left.right.equalTo(@0);
    }];
    
    self.lblBirthAddress = YXYLabel.new;
    UIView *v2 = [self createUIViewWithImage:LoadImageWithName(@"location") title:@"出生地" view:self.lblBirthAddress];
    [view addSubview:v2];
    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v1.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@25);
    }];
    
    self.btnFutureCity = YXYButton.new;
    self.btnFutureCity.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIView *v3 = [self createUIViewWithImage:LoadImageWithName(@"mine_future") title:@"未来想去" view:self.btnFutureCity];
    [view addSubview:v3];
    [v3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v2.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@25);
    }];
    
    self.btnAgoCity = YXYButton.new;
    self.btnAgoCity.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIView *v4 = [self createUIViewWithImage:LoadImageWithName(@"mine_ago") title:@"曾去过" view:self.btnAgoCity];
    [view addSubview:v4];
    [v4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v3.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@25);
    }];
    
    UIView *vSpit2 = UIView.new;
    vSpit2.backgroundColor = Color_Main;
    [view addSubview:vSpit2];
    [vSpit2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v4.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.width.equalTo(@3);
        make.height.equalTo(@16);
        make.bottom.equalTo(@(-5));
    }];
    
    YXYLabel *lbl = YXYLabel.new;
    lbl.title(@"个人动态").color(Color_3).titleFont(Font_PingFang_Medium(18));
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vSpit2.mas_right).offset(10);
        make.centerY.equalTo(vSpit2);
    }];
    return view;
}

- (UIView *)createUIViewWithImage:(UIImage *)image title:(NSString *)title view:(UIView *)view{
    UIView *v = UIView.new;
    v.backgroundColor = UIColor.clearColor;
   
    YXYButton *btn = [[YXYButton alloc] init];
    btn.setImgae(image, UIControlStateNormal);
    btn.enabled = NO;
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(v);
        make.width.equalTo(@15);
    }];
    
    YXYLabel *lbl = YXYLabel.new;
    lbl.title(title).color(ColorWithHex(@"999999")).titleFont(Font_PingFang_Medium(14));
    [v addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(v);
        make.left.equalTo(btn.mas_right).offset(5);
        make.width.equalTo(@60);
    }];
    
    [v addSubview:view];
    if ([view isKindOfClass:[YXYButton class]]) {
        YXYButton *btn = (YXYButton *)view;
        btn.color(Color_3, UIControlStateNormal).titleFont(Font_PingFang_Medium(14));
    }
    if ([view isKindOfClass:[YXYLabel class]]) {
        YXYLabel *lbl = (YXYLabel *)view;
        lbl.titleFont(Font_PingFang_Medium(14)).color(Color_3);
    }
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl.mas_right).offset(35);
        make.centerY.equalTo(v);
        make.right.equalTo(v);
    }];
    return v;
}

- (void)btnEditClicked{
    if (self.EditBlock) {
        self.EditBlock();
    }
}

- (YXYButton *)btnEdit{
    if (!_btnEdit) {
        _btnEdit = YXYButton.new;
        [_btnEdit setImage:LoadImageWithName(@"mine_edit") forState:UIControlStateNormal];
        [_btnEdit addTarget:self action:@selector(btnEditClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEdit;
}

- (UIImageView *)imgVUserIcon{
    if (!_imgVUserIcon) {
        _imgVUserIcon = [[UIImageView alloc] init];
        _imgVUserIcon.image = LoadImageWithName(@"placeholder");
        _imgVUserIcon.layer.borderColor = UIColor.whiteColor.CGColor;
        _imgVUserIcon.layer.borderWidth = 2;
        [_imgVUserIcon setCornerRadius:42];
        _imgVUserIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgVUserIcon;
}
@end
