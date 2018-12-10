//
//  MineHeaderCell.m
//  YouTo
//
//  Created by apple on 2018/12/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineHeaderCell.h"
#import "UIButton+WebCache.h"

@implementation MineHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.imgVBg.layer.masksToBounds = YES;
    self.btnEditTopConstraint.constant = STATUS_BAR_HEIGHT + 15;
    self.btnIconTopConstraint.constant = STATUS_BAR_HEIGHT + 52;
    [self.btnIcon setCornerRadius:42];
    self.btnIcon.layer.borderColor = WhiteColor.CGColor;
    self.btnIcon.layer.borderWidth = 2;
    
    [self.contentView addSubview:self.levelName];
    [self.contentView addSubview:self.vlevel];
    [self.contentView addSubview:self.levelRank];
    [self.contentView addSubview:self.levelNum];
    
    [self.levelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgVRank);
        make.right.equalTo(self.imgVRank.mas_right).offset(-5);
    }];
    [self.vlevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgVRank.mas_top).offset(4);
        make.left.equalTo(self.imgVRank.mas_right).offset(9);
        make.height.equalTo(@4);
        make.right.equalTo(@(-54));
    }];
    [self.levelRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgVRank.mas_right).offset(9);
        make.top.equalTo(self.vlevel.mas_bottom).offset(1);
    }];
    [self.levelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vlevel.mas_bottom).offset(1);
        make.right.equalTo(self.vlevel);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(UserModel *)model{
    if (!model) return;
    
    _model = model;
    
    [self.btnIcon sd_setImageWithURL:URLWithStr(model.headImg) forState:UIControlStateNormal placeholderImage:self.btnIcon.currentImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.btnIcon setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }];
    self.lblName.text = model.nickName;
    self.levelName.text = model.levelName;
    self.levelRank.text = model.levelName2;
    self.levelNum.text = [NSString stringWithFormat:@"成长值 %@/%@", model.levelScore, model.levelNextLevel];
    self.lblSign.text = model.personalizedSignature;
    self.vlevel.percent = 0.8;
}

- (IBAction)btnEditClicked:(id)sender {
    if (self.EditBlock) {
        self.EditBlock();
    }
}

- (IBAction)btnIconClicked:(id)sender {
    if (self.IconBlock) {
        self.IconBlock();
    }
}

- (YXYLabel *)levelNum{
    if (!_levelNum) {
        _levelNum = [[YXYLabel alloc] init];
        _levelNum.titleFont(Font_PingFang_Medium(9)).color(WhiteColor);
    }
    return _levelNum;
}

- (YXYLabel *)levelName{
    if (!_levelName) {
        _levelName = [[YXYLabel alloc] init];
        _levelName.titleFont(Font_PingFang_Bold(11)).color(WhiteColor);
    }
    return _levelName;
}

- (YXYLabel *)levelRank{
    if (!_levelRank) {
        _levelRank = [[YXYLabel alloc] init];
        _levelRank.titleFont(Font_PingFang_Bold(9)).color(WhiteColor);
    }
    return _levelRank;
}

- (LevelView *)vlevel{
    if (!_vlevel) {
        _vlevel = [[LevelView alloc] init];
        _vlevel.backgroundColor = ColorWithHex(@"#574d50");
        [_vlevel setCornerRadius:2];
    }
    return _vlevel;
}
@end
